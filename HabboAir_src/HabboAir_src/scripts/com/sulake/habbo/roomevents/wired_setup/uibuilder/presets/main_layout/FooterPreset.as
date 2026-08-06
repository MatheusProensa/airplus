package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SplitterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FooterPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var _splitter:SplitterPreset;
      
      private var UnknownVarFromFooterPreset_ButtonRowPreset_1:ButtonRowPreset;
      
      private var UnknownVarFromFooterPreset_ButtonPreset_1:ButtonPreset;
      
      public function FooterPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function, param5:Function)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         _splitter = param2.createSplitter();
         UnknownVarFromFooterPreset_ButtonPreset_1 = param2.createButton(loc("wiredfurni.ready"),param4);
         var _loc6_:ButtonPreset = param2.createButton(loc("cancel"),param5);
         UnknownVarFromFooterPreset_ButtonRowPreset_1 = param2.createButtonRow([UnknownVarFromFooterPreset_ButtonPreset_1,_loc6_]);
         UnknownVarFromFooterPreset_ButtonRowPreset_1.window.x = param3.sectionLeftRightMargin;
         _container.spacing = UnknownVarFromWiredUIPreset_WiredStyle_1.sectionSpacing;
         _container.addListItem(_splitter.window);
         _container.addListItem(UnknownVarFromFooterPreset_ButtonRowPreset_1.window);
      }
      
      public function set saveButtonDisabled(param1:Boolean) : void
      {
         UnknownVarFromFooterPreset_ButtonPreset_1.disabled = param1;
      }
      
      public function set saveButtonCaption(param1:String) : void
      {
         if(UnknownVarFromFooterPreset_ButtonPreset_1 != null && UnknownVarFromFooterPreset_ButtonPreset_1.window != null)
         {
            UnknownVarFromFooterPreset_ButtonPreset_1.window.caption = param1;
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      public function set splitterVisible(param1:Boolean) : void
      {
         _splitter.visible = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         _splitter.resizeToWidth(param1);
         UnknownVarFromFooterPreset_ButtonRowPreset_1.resizeToWidth(param1 - UnknownVarFromWiredUIPreset_WiredStyle_1.sectionLeftRightMargin * 2);
      }
      
      override protected function get childPresets() : Array
      {
         return [_splitter,UnknownVarFromFooterPreset_ButtonRowPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         _splitter = null;
         UnknownVarFromFooterPreset_ButtonRowPreset_1 = null;
         UnknownVarFromFooterPreset_ButtonPreset_1 = null;
      }
   }
}

