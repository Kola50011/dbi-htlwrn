create or replace package body cards
as

    function new_deck
      return deck_t
    as
        l_deck deck_t := deck_t();
    begin
        l_deck.extend(52);
        for color in 1..4 
        loop        
            for rank_num in 1..13
            loop
                l_deck(((color - 1) * 13) + rank_num) := ranks(rank_num) || suits(color);
            end loop;
        
        end loop;
        return l_deck;
    end;
    
    function suit(
        card card_t
    ) return suit_t
    as
        l_suit cards.suit_t;
    begin
        select substr(trim(card), -1)
          into l_suit
          from dual;
        
        return l_suit;
    end;
    
    function rank(
        card card_t
    ) return rank_t
    as
        l_rank cards.rank_t;
    begin
        select reverse(substr(reverse(trim(card)), 2))
          into l_rank
          from dual;
          
        return l_rank;    
    end;
    
    function same_suit(
        card1 card_t,
        card2 card_t
    ) return boolean
    as
    begin
        return suit(card1) = suit(card2);
    end;

    function same_rank(
        card1 card_t,
        card2 card_t
    ) return boolean
    as
    begin
        return rank(card1) = rank(card2);
    end;
    
    procedure print_deck(
        deck in deck_t
    )
    as
    begin
        for deck_idx in deck.first..deck.last loop
            dbms_output.put_line(replace(deck(deck_idx), ' ', '') || ',');
        end loop;
        dbms_output.put_line('');
    end;
    
    procedure shuffle_deck(
        deck in out deck_t
    )
    as
        l_idx integer;
        l_swappable cards.card_t;
    begin
        for idx in reverse deck.first..(deck.last - 1) loop
            l_idx := dbms_random.value(1, idx);
            l_swappable := deck(idx);
            deck(idx) := deck(l_idx);
            deck(l_idx) := l_swappable;
        end loop;
    end;
    
    function deal_clock(
        deck deck_t
    ) return layout_t
    as
        l_ret layout_t := layout_t();
    begin
        l_ret.extend(13);
        
        for l_idx in 1..13 loop
            l_ret(l_idx) := deck_t();
            l_ret(l_idx).extend(4);
        end loop;
        
        for idx in deck.first..deck.last loop
            l_ret(mod(idx, 13) + 1)(mod(idx, 4) + 1) := deck(idx);
        end loop;
        
        return l_ret;
    
    end;
    
    procedure print_layout(
        layout layout_t
    )
    as
    begin
        for idx in layout.first..layout.last loop
            dbms_output.put_line(idx || ': ');
            print_deck(layout(idx));
        end loop;
    end;
    
    function rank_value(
        card card_t
    ) return integer
    as
    begin
        for idx in ranks.first..ranks.last loop
            if (ranks(idx) = rank(card)) then
                return idx;
            end if;
        end loop;
    end;

    function draw_top(
        deck in out deck_t
    ) return card_t
    as
        result card_t;
    begin
        if (deck.count > 0) then
            result := deck(deck.last);
            deck.trim(1);

            return result;
        else
            return null;
        end if;
    end;
    
    function play_clock(
        deck in deck_t
    ) return boolean
    as
        layout layout_t; 
        deckPos integer := 13;
    begin        
        layout := deal_clock(deck);
        loop
            if layout(deckPos).count = 0 then
                exit;
            end if;
            deckPos := rank_value(draw_top(layout(deckPos)));
        end loop;
        for i in 1..layout.count loop
            if layout(i).count != 0 then
                return false;
            end if;
        end loop;     
        
        return true;
    end;
begin

    suits.extend(4);
    suits(1) := cards.spade;
    suits(2) := cards.heart;
    suits(3) := cards.diamond;
    suits(4) := cards.club;
    
    ranks.extend(13);
    ranks(1) := 'A';
    ranks(2) := '2';
    ranks(3) := '3';
    ranks(4) := '4';
    ranks(5) := '5';
    ranks(6) := '6';
    ranks(7) := '7';
    ranks(8) := '8';
    ranks(9) := '9';
    ranks(10) := '10';
    ranks(11) := 'J';
    ranks(12) := 'Q';
    ranks(13) := 'K';    

end cards;
/
show errors