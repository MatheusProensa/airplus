package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NamedTextInputPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var UnknownVarFromNamedTextInputPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromNamedTextInputPreset_TextInputPreset_1:TextInputPreset;
      
      public function NamedTextInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:TextInputParam, param5:String, param6:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("horizontal_list_view") as IItemListWindow;
         UnknownVarFromNamedTextInputPreset_TextPreset_1 = param2.createText(param5,new TextParam(0,param6));
         UnknownVarFromNamedTextInputPreset_TextPreset_1.window.y = param3.namedTextYOffset;
         UnknownVarFromNamedTextInputPreset_TextInputPreset_1 = param2.createTextInput(param4);
         UnknownVarFromNamedTextInputPreset_TextPreset_1.window.y = param3.namedInputOffset;
         _container.spacing = param3.genericHorizontalSpacing;
         _container.addListItem(UnknownVarFromNamedTextInputPreset_TextPreset_1.window);
         _container.addListItem(UnknownVarFromNamedTextInputPreset_TextInputPreset_1.window);
         _container.height = Math.max(UnknownVarFromNamedTextInputPreset_TextPreset_1.window.height,UnknownVarFromNamedTextInputPreset_TextInputPreset_1.window.height);
      }
      
      public function get text() : String
      {
         return UnknownVarFromNamedTextInputPreset_TextInputPreset_1.text;
      }
      
      public function set text(param1:String) : void
      {
         UnknownVarFromNamedTextInputPreset_TextInputPreset_1.text = param1;
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromNamedTextInputPreset_TextInputPreset_1.addEventListener(param1,param2);
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromNamedTextInputPreset_TextInputPreset_1.removeEventListener(param1,param2);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return UnknownVarFromNamedTextInputPreset_TextInputPreset_1.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         if(hasStaticWidth())
         {
            return _container.width;
         }
         throw new Exception("Text input has no static width");
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         UnknownVarFromNamedTextInputPreset_TextPreset_1.resizeToWidth(UnknownVarFromNamedTextInputPreset_TextPreset_1.width);
         UnknownVarFromNamedTextInputPreset_TextInputPreset_1.resizeToWidth(param1 - UnknownVarFromNamedTextInputPreset_TextInputPreset_1.window.x);
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromNamedTextInputPreset_TextPreset_1,UnknownVarFromNamedTextInputPreset_TextInputPreset_1];
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
         UnknownVarFromNamedTextInputPreset_TextPreset_1 = null;
         UnknownVarFromNamedTextInputPreset_TextInputPreset_1 = null;
      }
   }
}

