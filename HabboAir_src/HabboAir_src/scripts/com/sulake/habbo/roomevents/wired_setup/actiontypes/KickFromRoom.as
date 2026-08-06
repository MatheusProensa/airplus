package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class KickFromRoom extends DefaultActionType
   {
      private var UnknownVarFromKickFromRoom_TextInputPreset_1:TextInputPreset;
      
      public function KickFromRoom()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.KICK_FROM_ROOM;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromKickFromRoom_TextInputPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromKickFromRoom_TextInputPreset_1.text = param1.stringParam;
      }
      
      override public function validate() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = 100;
         if(UnknownVarFromKickFromRoom_TextInputPreset_1.text.length > _loc1_)
         {
            _loc2_ = "wiredfurni.chatmsgtoolong";
            return roomEvents.localization.getLocalization(_loc2_,_loc2_);
         }
         return null;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromKickFromRoom_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",100));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.message}",UnknownVarFromKickFromRoom_TextInputPreset_1);
         param3.addElements(_loc4_);
      }
   }
}

