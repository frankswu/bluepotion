# An Activity designed to host a stack of fragments/screens.
# RM-733
#module ProMotion
  class PMNavigationActivity < PMActivity
    attr_accessor :fragment_container, :root_fragment, :menu

    def on_create(saved_instance_state)
      super
      # mp "PMNavigationActivity on_create", debugging_only: true
      activity_init
    end

    def on_create_menu(menu)
      @menu = menu
      self.fragment.on_create_menu(menu) if self.fragment
    end

    def on_options_item_selected(item)
      self.fragment.on_options_item_selected(item) if self.fragment
    end

    def open_fragment(frag, options={})
      mp frag
      mgr = fragmentManager.beginTransaction
      mgr.add(@fragment_container.getId, frag, frag.class.to_s)
      mgr.addToBackStack(nil)
      mgr.commit
      frag
    end

    def fragment
      self.fragments.last
    end

    def fragments
      @fragments ||= []
    end

    def on_fragment_attached(frag)
      self.fragments << frag
    end

    def on_fragment_detached(frag)
      self.fragments.pop
    end

    private

    def activity_init
      setup_root_fragment_container
      setup_root_fragment root_fragment_instance
      open_fragment root_fragment_instance if root_fragment_instance
    end

    def setup_root_fragment(frag)
      return unless frag && intent_fragment_arguments
      PMHashBundle.from_bundle(intent_fragment_arguments).to_h.each do |key, value|
        frag.send "#{key}=", value
      end
    end

    def intent_fragment_arguments
      intent.getBundleExtra(EXTRA_FRAGMENT_ARGUMENTS)
    end

    def root_fragment_instance
      @root_fragment ||= intent_fragment_class && Kernel.const_get(intent_fragment_class.to_s).new
    end

    def intent_fragment_class
      intent.getStringExtra(EXTRA_FRAGMENT_CLASS)
    end

    def setup_root_fragment_container
      @fragment_container = Potion::FrameLayout.new(self)
      @fragment_container.setId Potion::ViewIdGenerator.generate
      self.contentView = @fragment_container
    end

  end
#end
