package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.room.IRoomAreaSelectionManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class InArea extends DefaultSelectorType
   {
      private var UnknownVarFromInArea_IRoomAreaSelectionManager_1:IRoomAreaSelectionManager;
      
      private var UnknownVarFromInArea_Int_1:int;
      
      private var UnknownVarFromInArea_Int_2:int;
      
      private var _width:int;
      
      private var UnknownVarFromInArea_Int_3:int;
      
      private var UnknownVarFromInArea_Boolean_1:Boolean = false;
      
      private var UnknownVarFromInArea_ButtonPreset_1:ButtonPreset;
      
      private var UnknownVarFromInArea_ButtonPreset_2:ButtonPreset;
      
      private var UnknownVarFromInArea_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromInArea_UnknownICoreWindowComponents4_2:UnknownICoreWindowComponents4;
      
      public function InArea()
      {
         super();
      }
      
      private static function enableButton(param1:UnknownICoreWindowComponents4, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
      
      override public function onInit(param1:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1);
         UnknownVarFromInArea_IRoomAreaSelectionManager_1 = param1.roomEngine.areaSelectionManager;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         if(!UnknownVarFromInArea_Boolean_1)
         {
            UnknownVarFromInArea_Boolean_1 = UnknownVarFromInArea_IRoomAreaSelectionManager_1.activate(onAreaSelected,"highlight_brighten");
         }
         UnknownVarFromInArea_Int_1 = param1.intParams[0];
         UnknownVarFromInArea_Int_2 = param1.intParams[1];
         _width = param1.intParams[2];
         UnknownVarFromInArea_Int_3 = param1.intParams[3];
         if(UnknownVarFromInArea_Boolean_1)
         {
            UnknownVarFromInArea_IRoomAreaSelectionManager_1.setHighlight(UnknownVarFromInArea_Int_1,UnknownVarFromInArea_Int_2,_width,UnknownVarFromInArea_Int_3);
            enableButton(UnknownVarFromInArea_UnknownICoreWindowComponents4_1,true);
            enableButton(UnknownVarFromInArea_UnknownICoreWindowComponents4_2,true);
         }
         else
         {
            enableButton(UnknownVarFromInArea_UnknownICoreWindowComponents4_1,false);
            enableButton(UnknownVarFromInArea_UnknownICoreWindowComponents4_2,false);
         }
      }
      
      override public function onEditEnd() : void
      {
         super.onEditEnd();
         if(UnknownVarFromInArea_Boolean_1)
         {
            UnknownVarFromInArea_IRoomAreaSelectionManager_1.deactivate();
            UnknownVarFromInArea_Boolean_1 = false;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromInArea_Int_1);
         _loc1_.push(UnknownVarFromInArea_Int_2);
         _loc1_.push(_width);
         _loc1_.push(UnknownVarFromInArea_Int_3);
         return _loc1_;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:TextParam = new TextParam(1);
         _loc5_.textColor = param2.softTextColor;
         var _loc4_:TextPreset = param1.createText(l("area_selection.info"),_loc5_);
         UnknownVarFromInArea_ButtonPreset_1 = param1.createButton(l("area_selection.select"),onSelect);
         UnknownVarFromInArea_ButtonPreset_2 = param1.createButton(l("area_selection.clear"),onClear);
         var _loc7_:ButtonRowPreset = param1.createButtonRow([UnknownVarFromInArea_ButtonPreset_1,UnknownVarFromInArea_ButtonPreset_2]);
         var _loc6_:SectionPreset = param1.createSection(l("area_selection"),param1.createSimpleListView(true,[_loc4_,_loc7_]));
         param3.addElements(_loc6_);
         UnknownVarFromInArea_UnknownICoreWindowComponents4_1 = UnknownVarFromInArea_ButtonPreset_1.window as UnknownICoreWindowComponents4;
         UnknownVarFromInArea_UnknownICoreWindowComponents4_2 = UnknownVarFromInArea_ButtonPreset_2.window as UnknownICoreWindowComponents4;
      }
      
      private function onSelect() : void
      {
         enableButton(UnknownVarFromInArea_UnknownICoreWindowComponents4_1,false);
         UnknownVarFromInArea_IRoomAreaSelectionManager_1.startSelecting();
      }
      
      private function onClear() : void
      {
         UnknownVarFromInArea_IRoomAreaSelectionManager_1.clearHighlight();
      }
      
      private function onAreaSelected(param1:int, param2:int, param3:int, param4:int) : void
      {
         enableButton(UnknownVarFromInArea_UnknownICoreWindowComponents4_1,true);
         UnknownVarFromInArea_Int_1 = param1;
         UnknownVarFromInArea_Int_2 = param2;
         _width = param3;
         UnknownVarFromInArea_Int_3 = param4;
      }
   }
}

