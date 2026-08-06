package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderTypeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UsernamePlaceholderAddon extends DefaultAddonType
   {
      private var UnknownVarFromUsernamePlaceholderAddon_PlaceholderNameSection_1:PlaceholderNameSection;
      
      private var UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1:PlaceholderTypeSection;
      
      public function UsernamePlaceholderAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.USERNAME_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromUsernamePlaceholderAddon_PlaceholderNameSection_1 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1 = param1.createPlaceholderTypeSection("user");
         param3.addElements(UnknownVarFromUsernamePlaceholderAddon_PlaceholderNameSection_1,UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         var _loc5_:Boolean = param1.getBoolean(0);
         var _loc4_:String = _loc2_[0];
         var _loc3_:String = _loc2_.length > 1 ? _loc2_[1] : "";
         UnknownVarFromUsernamePlaceholderAddon_PlaceholderNameSection_1.placeholderName = _loc4_;
         UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple = _loc5_;
         UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1.delimiter = _loc3_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         if(!UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple)
         {
            return UnknownVarFromUsernamePlaceholderAddon_PlaceholderNameSection_1.placeholderName;
         }
         return UnknownVarFromUsernamePlaceholderAddon_PlaceholderNameSection_1.placeholderName + "\t" + UnknownVarFromUsernamePlaceholderAddon_PlaceholderTypeSection_1.delimiter;
      }
   }
}

