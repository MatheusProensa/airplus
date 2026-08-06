package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderTypeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FurniNamePlaceholderAddon extends DefaultAddonType
   {
      private var UnknownVarFromFurniNamePlaceholderAddon_PlaceholderNameSection_1:PlaceholderNameSection;
      
      private var UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1:PlaceholderTypeSection;
      
      public function FurniNamePlaceholderAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.FURNI_NAME_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromFurniNamePlaceholderAddon_PlaceholderNameSection_1 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1 = param1.createPlaceholderTypeSection("furni");
         param3.addElements(UnknownVarFromFurniNamePlaceholderAddon_PlaceholderNameSection_1,UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         var _loc5_:Boolean = param1.getBoolean(0);
         var _loc4_:String = _loc2_[0];
         var _loc3_:String = _loc2_.length > 1 ? _loc2_[1] : "";
         UnknownVarFromFurniNamePlaceholderAddon_PlaceholderNameSection_1.placeholderName = _loc4_;
         UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple = _loc5_;
         UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1.delimiter = _loc3_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         if(!UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1.isShowMultiple)
         {
            return UnknownVarFromFurniNamePlaceholderAddon_PlaceholderNameSection_1.placeholderName;
         }
         return UnknownVarFromFurniNamePlaceholderAddon_PlaceholderNameSection_1.placeholderName + "\t" + UnknownVarFromFurniNamePlaceholderAddon_PlaceholderTypeSection_1.delimiter;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

