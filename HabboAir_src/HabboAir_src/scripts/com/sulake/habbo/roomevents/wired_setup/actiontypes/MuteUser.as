package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MuteUser extends DefaultActionType
   {
      private var UnknownVarFromMuteUser_TextInputPreset_1:TextInputPreset;
      
      private var UnknownVarFromMuteUser_SliderSection_1:SliderSection;
      
      public function MuteUser()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MUTE_USER;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromMuteUser_TextInputPreset_1.text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMuteUser_SliderSection_1.value];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMuteUser_TextInputPreset_1.text = param1.stringParam;
         UnknownVarFromMuteUser_SliderSection_1.value = param1.intParams[0];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function validate() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = 100;
         if(UnknownVarFromMuteUser_TextInputPreset_1.text.length > _loc1_)
         {
            _loc2_ = "wiredfurni.chatmsgtoolong";
            return roomEvents.localization.getLocalization(_loc2_,_loc2_);
         }
         return null;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromMuteUser_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",100));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.message}",UnknownVarFromMuteUser_TextInputPreset_1);
         UnknownVarFromMuteUser_SliderSection_1 = param1.createSliderSection("wiredfurni.params.length.minutes","minutes",SliderSection.CONVERTER_ECHO,0,10,1);
         UnknownVarFromMuteUser_SliderSection_1.value = 1;
         param3.addElements(_loc4_,UnknownVarFromMuteUser_SliderSection_1);
      }
   }
}

