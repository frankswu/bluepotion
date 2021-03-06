# AKA a list with custom views
class ExampleCustomTableCellsScreen < PMListScreen
  stylesheet ExampleCustomTableCellsScreenStylesheet
  title "Example Custom Table Cells"

  def load_view
    mp "ExampleTableScreen load_view"
    Potion::ListView.new(self.activity)
  end

  def table_data
    [{
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      # Illustrating a basic Cell - Nothing Fancy
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      title: "Custom Cell Table/ListView",
      cells: [{
        title: "I'm a Regular Cell"
      },{
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      # Illustrating a XML Cell - Update via Screen
      # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        title: "XML Custom Image Cell 1",
        cell_xml: R::Layout::Image_cell,
        update: :update_xml_cell,
        action: :make_magic,
        arguments: { saying: "SUCH WOW" }
      },{
        title: "XML Custom Imge Cell 2",
        cell_xml: R::Layout::Image_cell,
        update: :update_xml_cell,
        action: :make_magic,
        arguments: { other_saying: "MUCH AMAZE" }
      }
      #,{
      ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      ## Illustrating Cell Class - Update via Class
      ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        #cell_class: ImageCell,
        #action: :make_magic,
        #arguments: { simple: "!!!!!"},
        #properties: {
          #custom_name: "Random Color Cell Class",
          #color: rmq.color.random,
          #i_dont_exist: true
        #}
      #}
      ]
    }]
  end

  # Cell logic in the screen for XML
  def make_magic(args, position)
    mp args
  end

  def update_xml_cell(cell, cell_data)
    # Let's set the cell info - specific to Image_cell
    rmq_cell = find(cell)
    rmq_cell.find(Potion::Label).data = cell_data[:title]
    rmq_cell.find(Potion::ImageView).get.imageResource = rmq.image.resource("ic_launcher")
  end
end
