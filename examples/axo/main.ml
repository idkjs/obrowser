
open AXOLang


let body = AXOJs.Node.document >>> AXOJs.Node.get_element_by_id "body"

let test_tree =
  LTree.node "test"
   [ LTree.node "Un"
      [ LTree.node "toto" [] ;
        LTree.node "fait" [] ;
        LTree.node "la"   [] ;
        LTree.node "cuisine" [] ;
      ] ;
     LTree.node "2"
      [ LTree.node "sdjrhg" [] ;
        LTree.node "fadsrgr" [] ;
        LTree.node "cdsfssdise" [] ;
      ] ;
     LTree.node "3"
      [] ;
     LTree.node "Cinq"
      [ LTree.node "sdjrhg" [] ;
        LTree.node "fgr" [] ;
        LTree.node "cdsfssdise"
         [ LTree.node "haha"
            [ LTree.node "hihi"
                [ LTree.node "hoho"
                    [ LTree.node "huhu" []
                    ] ;
                ] ;
            ] ;
         ];
      ] ;
   ]

let content = new AXOWidgets.block_text_widget "esfblhf kjhvljkdsf kg"


let f =
  AXOToolkit.foldable
    (new AXOWidgets.inline_text_cyclic_button
        ("Expand",true)
       [("Fold" , false)])
    (content :> AXOWidgets.generic AXOWidgets.generic_widget)

let _ =
  AXOWidgets.body_container#add_widget
    (f :> AXOWidgets.generic AXOWidgets.generic_widget)
