create or replace package cards
as
    spade   constant char(1 char) := unistr('\2660');
    heart   constant char(1 char) := unistr('\2665');
    diamond constant char(1 char) := unistr('\2666');
    club    constant char(1 char) := unistr('\2663');
  
    subtype card_t is char(3 char);
    subtype suit_t is char(1 char);
    subtype rank_t is char(2 char);
  
    type ranks_t is table of rank_t;
    type suits_t is table of suit_t;
    type deck_t is table of card_t;
    
    type layout_t is table of deck_t;
  
    suits suits_t := suits_t();
    ranks ranks_t := ranks_t();
  
    function new_deck
      return deck_t;
    
    function suit(
        card card_t
    ) return suit_t;
    
    function rank(
        card card_t
    ) return rank_t;
    
    function same_suit(
        card1 card_t,
        card2 card_t
    ) return boolean;
    
    function same_rank(
        card1 card_t,
        card2 card_t
    ) return boolean;
    
    procedure print_deck(
        deck in deck_t
    );
    
    procedure shuffle_deck(
        deck in out deck_t
    );
    
    function deal_clock(
        deck deck_t
    ) return layout_t;
    
    procedure print_layout(
        layout layout_t
    );

    function rank_value(
        card card_t
    ) return integer;
 
    function draw_top(
        deck in out deck_t
    ) return card_t;

    function play_clock(
        deck in deck_t
    ) return boolean;


end cards;
/
show errors