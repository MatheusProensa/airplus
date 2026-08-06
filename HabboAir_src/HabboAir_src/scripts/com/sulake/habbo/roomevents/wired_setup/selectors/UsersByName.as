package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextAreaPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UsersByName extends DefaultSelectorType
   {
      private var UnknownVarFromUsersByName_TextAreaPreset_1:TextAreaPreset;
      
      public function UsersByName()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_BY_NAME;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = UnknownVarFromUsersByName_TextAreaPreset_1.text;
         return _loc1_.replace(/\n\r/g,"\t").replace(/\r/g,"\t").replace(/\n/g,"\t");
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromUsersByName_TextAreaPreset_1.text = param1.stringParam.replace(/\t/g,"\r");
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromUsersByName_TextAreaPreset_1 = param1.createTextArea(new TextAreaParam(140,-1,20,-1,1000));
         var _loc4_:SectionPreset = param1.createSection("${wiredfurni.params.enter_names}",UnknownVarFromUsersByName_TextAreaPreset_1);
         param3.addElements(_loc4_);
      }
   }
}

