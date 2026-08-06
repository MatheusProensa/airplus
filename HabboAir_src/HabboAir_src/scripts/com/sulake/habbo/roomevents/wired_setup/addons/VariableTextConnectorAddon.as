package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariableTextConnectorAddon extends DefaultAddonType
   {
      private var _textInput:TextAreaPreset;
      
      public function VariableTextConnectorAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.VARIABLE_TEXT_CONVERTER;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _textInput.text = param1.stringParam;
      }
      
      override public function readStringParamFromForm() : String
      {
         return _textInput.text;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _textInput = param1.createTextArea(new TextAreaParam(100,-1,30,-1,1000,"",l("variables.connect_text.caption")));
         var _loc4_:SectionPreset = param1.createSection(l("variables.connect_text.title"),_textInput);
         param3.addElements(_loc4_);
      }
   }
}

