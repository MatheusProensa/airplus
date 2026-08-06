package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RewardRowPreset extends WiredUIPreset
   {
      private var UnknownVarFromRewardRowPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var _window:IWindowController_1;
      
      private var _badgeCheckbox:UnknownICoreWindowComponents2;
      
      private var UnknownVarFromRewardRowPreset_TextInputPreset_1:TextInputPreset;
      
      private var UnknownVarFromRewardRowPreset_TextInputPreset_2:TextInputPreset;
      
      private var UnknownVarFromRewardRowPreset_Int_1:int;
      
      private var UnknownVarFromRewardRowPreset_Boolean_1:Boolean = true;
      
      public function RewardRowPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _badgeCheckbox = param3.createCheckboxView();
         UnknownVarFromRewardRowPreset_TextInputPreset_1 = param2.createTextInput(new TextInputParam("",100,null,-1,null,true,"Product code or badge code"));
         UnknownVarFromRewardRowPreset_TextInputPreset_2 = param2.createTextInput(new TextInputParam("",3,null,50,"0-9",true,"Chance to get this reward. Value should be a number between 1 and 100"));
         UnknownVarFromRewardRowPreset_Int_1 = param3.genericHorizontalSpacing;
         UnknownVarFromRewardRowPreset_TextInputPreset_2.disabled = !UnknownVarFromRewardRowPreset_Boolean_1;
         UnknownVarFromRewardRowPreset_SimpleListViewPreset_1 = param2.createSimpleListView(false,[wrapWindow(_badgeCheckbox,true),UnknownVarFromRewardRowPreset_TextInputPreset_1,UnknownVarFromRewardRowPreset_TextInputPreset_2]);
         UnknownVarFromRewardRowPreset_SimpleListViewPreset_1.spacing = UnknownVarFromRewardRowPreset_Int_1;
         _window = param2.createLayout("container_view") as IWindowController_1;
         _window.addChild(UnknownVarFromRewardRowPreset_SimpleListViewPreset_1.window);
      }
      
      public function get code() : String
      {
         return UnknownVarFromRewardRowPreset_TextInputPreset_1.text;
      }
      
      public function set code(param1:String) : void
      {
         UnknownVarFromRewardRowPreset_TextInputPreset_1.text = param1 == null ? "" : param1;
      }
      
      public function get probabilityText() : String
      {
         return UnknownVarFromRewardRowPreset_TextInputPreset_2.text;
      }
      
      public function set probabilityText(param1:String) : void
      {
         UnknownVarFromRewardRowPreset_TextInputPreset_2.text = param1 == null ? "" : param1;
      }
      
      public function get isBadge() : Boolean
      {
         return _badgeCheckbox.isSelected;
      }
      
      public function set isBadge(param1:Boolean) : void
      {
         Util.select(_badgeCheckbox,param1);
      }
      
      public function clear() : void
      {
         code = "";
         probabilityText = "";
         isBadge = false;
      }
      
      public function setProbabilityVisible(param1:Boolean) : void
      {
         UnknownVarFromRewardRowPreset_Boolean_1 = param1;
         UnknownVarFromRewardRowPreset_TextInputPreset_2.disabled = !UnknownVarFromRewardRowPreset_Boolean_1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
         UnknownVarFromRewardRowPreset_SimpleListViewPreset_1.resizeToWidth(param1);
         _window.height = UnknownVarFromRewardRowPreset_SimpleListViewPreset_1.window.height;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromRewardRowPreset_SimpleListViewPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
         UnknownVarFromRewardRowPreset_SimpleListViewPreset_1 = null;
         _badgeCheckbox = null;
         UnknownVarFromRewardRowPreset_TextInputPreset_1 = null;
         UnknownVarFromRewardRowPreset_TextInputPreset_2 = null;
      }
   }
}

