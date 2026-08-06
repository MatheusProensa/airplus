package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ResetRewardTrack extends DefaultActionType
   {
      private static const UnknownConstFromResetRewardTrack_String_1:String = "^\t";
      
      private var UnknownVarFromResetRewardTrack_NamedTextInputPreset_1:NamedTextInputPreset;
      
      public function ResetRewardTrack()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.RESET_REWARD_TRACK;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromResetRewardTrack_NamedTextInputPreset_1 = param1.createNamedTextInput(new TextInputParam("",100,null,-1,"^\t"),"${wiredfurni.params.reward_track.track_id}");
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.reward_track.reset.track}",UnknownVarFromResetRewardTrack_NamedTextInputPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromResetRewardTrack_NamedTextInputPreset_1.text;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromResetRewardTrack_NamedTextInputPreset_1.text = param1.stringParam;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

