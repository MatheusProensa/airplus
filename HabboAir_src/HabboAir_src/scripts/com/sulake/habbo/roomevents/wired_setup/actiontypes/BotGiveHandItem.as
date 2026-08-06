package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BotGiveHandItem extends UnknownHabboRoomeventsWired_SetupActiontypes1
   {
      private static const DEFAULT_CODES:Array = [0,2,5,7,8,9,10,27,1126,1127,1128];
      
      private var UnknownVarFromBotGiveHandItem_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var _botName:TextInputPreset;
      
      private var _handItemDropdown:DropdownPreset;
      
      private var UnknownVarFromBotGiveHandItem_ButtonPreset_1:ButtonPreset;
      
      private var UnknownVarFromBotGiveHandItem_Vector_1:Vector.<ExpandableDropdownOption>;
      
      public function BotGiveHandItem()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.BOT_GIVE_HAND_ITEM;
      }
      
      override public function readStringParamFromForm() : String
      {
         return UnknownVarFromBotGiveHandItem_CheckboxGroupPreset_1.get(0).selected ? _botName.text : "";
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:int = _handItemDropdown.selectedId;
         return [_loc1_ == -1 ? 0 : _loc1_];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:* = param1.stringParam != "";
         _botName.text = param1.stringParam;
         UnknownVarFromBotGiveHandItem_CheckboxGroupPreset_1.get(0).selected = _loc2_;
         _botName.window.visible = _loc2_;
         setSelectedHandItemByCode(param1.intParams[0]);
      }
      
      private function setSelectedHandItemByCode(param1:int) : void
      {
         ensureOptionExists(param1);
         _handItemDropdown.selectedId = param1;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromBotGiveHandItem_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam(l("bot.usage"))],onBotUsageChange);
         _botName = param1.createTextInput(new TextInputParam("",32,null,-1,null,true,loc("wiredfurni.tooltip.bot.name")));
         var _loc4_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromBotGiveHandItem_CheckboxGroupPreset_1,_botName]);
         var _loc5_:SectionPreset = param1.createSection(l("bot.name"),_loc4_);
         UnknownVarFromBotGiveHandItem_Vector_1 = createOptions(DEFAULT_CODES);
         _handItemDropdown = param1.createDropdown(new DropdownParam(loc("wiredfurni.tooltip.bot.handitem"),UnknownVarFromBotGiveHandItem_Vector_1));
         UnknownVarFromBotGiveHandItem_ButtonPreset_1 = param1.createButton(l("capture.handitem"),captureHanditem);
         var _loc6_:SectionPreset = param1.createSection(l("handitem"),param1.createSimpleListView(true,[_handItemDropdown,UnknownVarFromBotGiveHandItem_ButtonPreset_1]));
         param3.addElements(_loc5_,_loc6_);
      }
      
      private function onBotUsageChange(param1:int, param2:Boolean) : void
      {
         if(param1 != 0)
         {
            return;
         }
         _botName.window.visible = param2;
      }
      
      private function createOptions(param1:Array) : Vector.<ExpandableDropdownOption>
      {
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         for each(var _loc2_ in param1)
         {
            _loc3_.push(new ExpandableDropdownOption(_loc2_,"${handitem" + _loc2_ + "}"));
         }
         return _loc3_;
      }
      
      private function ensureOptionExists(param1:int) : void
      {
         var _loc4_:int = 0;
         if(param1 < 0)
         {
            return;
         }
         var _loc3_:Boolean = false;
         for each(var _loc2_ in UnknownVarFromBotGiveHandItem_Vector_1)
         {
            if(_loc2_.id == param1)
            {
               _loc3_ = true;
               break;
            }
         }
         if(!_loc3_)
         {
            UnknownVarFromBotGiveHandItem_Vector_1.push(new ExpandableDropdownOption(param1,"${handitem" + param1 + "}"));
         }
         var _loc5_:* = -1;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromBotGiveHandItem_Vector_1.length)
         {
            if(UnknownVarFromBotGiveHandItem_Vector_1[_loc4_].id == param1)
            {
               _loc5_ = _loc4_;
            }
            _loc4_++;
         }
         _handItemDropdown.reinit(UnknownVarFromBotGiveHandItem_Vector_1,_loc5_);
      }
      
      private function captureHanditem() : void
      {
         var _loc1_:int = roomEvents.roomEngine.getRoomObject(roomEvents.roomSession.roomId,roomEvents.roomSession.ownUserRoomId,100).getModel().getNumber("figure_carry_object");
         setSelectedHandItemByCode(_loc1_);
      }
   }
}

