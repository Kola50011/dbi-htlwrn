set serveroutput on size unlimited;

-- Ü 2

exec dbms_output.put_line(cards.spade || ' ' || cards.heart || ' ' || cards.diamond || ' ' || cards.club);

-- Ü 4

declare
    l_deck cards.deck_t := cards.new_deck;
begin
    for idx in l_deck.first..l_deck.last
    loop
        dbms_output.put_line('' || idx || ': ' || l_deck(idx));
    end loop;
end;
/
show error;

-- Ü 5

exec dbms_output.put_line(cards.suit('10' || cards.spade));
exec dbms_output.put_line(cards.suit('8' || cards.spade));


-- Ü 6

exec dbms_output.put_line(cards.rank('10' || cards.spade));
exec dbms_output.put_line(cards.rank('8' || cards.spade));
exec dbms_output.put_line(cards.rank('A' || cards.diamond));

-- Ü 7

declare
    l_card_1 cards.card_t := '10' || cards.spade;
    l_card_2 cards.card_t := 'A' || cards.diamond;
    l_card_3 cards.card_t := '3' || cards.heart;
    l_card_4 cards.card_t := '6' || cards.club;
begin
    dbms_output.put_line(l_card_1 || ' Farbe: ' || cards.suit(l_card_1) || ' Wert: ' || cards.rank(l_card_1));
    dbms_output.put_line(l_card_2 || ' Farbe: ' || cards.suit(l_card_2) || ' Wert: ' || cards.rank(l_card_2));
    dbms_output.put_line(l_card_3 || ' Farbe: ' || cards.suit(l_card_3) || ' Wert: ' || cards.rank(l_card_3));
    dbms_output.put_line(l_card_4 || ' Farbe: ' || cards.suit(l_card_4) || ' Wert: ' || cards.rank(l_card_4));
    
end;
/
show error;

-- Ü 8

declare
    l_card_1 cards.card_t := '10' || cards.spade;
    l_card_2 cards.card_t := 'A' || cards.spade;
    l_card_3 cards.card_t := '3' || cards.heart;
    l_card_4 cards.card_t := '3' || cards.club;
begin
    if cards.same_suit(l_card_1, l_card_2) then
        dbms_output.put_line(l_card_1 || ' und ' || l_card_2 || ' haben die selbe Farbe!');
    else
        dbms_output.put_line(l_card_1 || ' und ' || l_card_2 || ' haben nicht die selbe Farbe!');
    end if;
    
    if cards.same_suit(l_card_2, l_card_3) then
        dbms_output.put_line(l_card_2 || ' und ' || l_card_3 || ' haben die selbe Farbe!');
    else
        dbms_output.put_line(l_card_2 || ' und ' || l_card_3 || ' haben nicht die selbe Farbe!');
    end if;
    
    if cards.same_rank(l_card_2, l_card_3) then
        dbms_output.put_line(l_card_2 || ' und ' || l_card_3 || ' haben den selben Rang!');
    else
        dbms_output.put_line(l_card_2 || ' und ' || l_card_3 || ' haben nicht den selben Rang!');
    end if;
    
    if cards.same_rank(l_card_3, l_card_4) then
        dbms_output.put_line(l_card_3 || ' und ' || l_card_4 || ' haben den selben Rang!');
    else
        dbms_output.put_line(l_card_3 || ' und ' || l_card_4 || ' haben nicht den selben Rang!');
    end if;
end;
/
show error;

-- Ü 9

exec cards.print_deck(cards.new_deck());

-- Ü 10

declare
    l_deck cards.deck_t := cards.new_deck();
begin
    cards.shuffle_deck(l_deck);
    cards.print_deck(l_deck);
end;
/
show error;

-- Ü 15

declare
    l_deck cards.deck_t := cards.new_deck();
begin
    cards.shuffle_deck(l_deck);
    cards.print_layout(cards.deal_clock(l_deck));
end;
/
show error;

-- Ü 16

declare
    l_card_1 cards.card_t := '10' || cards.spade;
    l_card_2 cards.card_t := 'A' || cards.spade;
    l_card_3 cards.card_t := '3' || cards.heart;
    l_card_4 cards.card_t := '3' || cards.club;
begin
    dbms_output.put_line(cards.rank_value(l_card_1));
    dbms_output.put_line(cards.rank_value(l_card_2));
    dbms_output.put_line(cards.rank_value(l_card_3));
    dbms_output.put_line(cards.rank_value(l_card_4));
end;
/

-- Ü 17

declare
    l_deck cards.deck_t := cards.new_deck();
    l_card cards.card_t;
begin
    cards.shuffle_deck(l_deck);

    loop
        l_card := cards.draw_top(l_deck);
        dbms_output.put_line(l_card);

        exit when l_card is null;
    end loop;
end;
/
show error;

-- Übung 18

declare
    cardDeck cards.deck_t; 
begin
    cardDeck := cards.new_deck();
    cards.shuffle_deck(cardDeck);
    
    while not cards.play_clock(cardDeck) loop
        cardDeck := cards.new_deck();
        cards.shuffle_deck(cardDeck); 
        dbms_output.put_line('Loose');
    end loop;
    dbms_output.put_line('Win');
end;
/
show error; 

-- Ü 19

declare
    cardDeck cards.deck_t;
    attempts int := 1111;
    wins int := 0;
    losses int := 0;
    startTime number;
begin
    cardDeck := cards.new_deck();
    cards.shuffle_deck(cardDeck);
    startTime := dbms_utility.get_time(); 
    for i in 1..attempts loop
        cardDeck := cards.new_deck();
        cards.shuffle_deck(cardDeck); 
        if cards.play_clock(cardDeck) then
            wins := wins + 1;
        else
            losses := losses + 1;
        end if;
    end loop;
    
    dbms_output.put_line('Wins: ' || wins);
    dbms_output.put_line('Losses: ' || losses);
    dbms_output.put_line('Chance to win: ' || wins/attempts*100 || '%');
    dbms_output.put_line('Elapsed time: ' || 
                          to_char((dbms_utility.get_time()-startTime))/100 || 's');
end;
