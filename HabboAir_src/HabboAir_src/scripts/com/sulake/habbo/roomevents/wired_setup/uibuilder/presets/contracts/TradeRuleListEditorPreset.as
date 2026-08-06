package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TradeRuleListEditorPreset extends WiredUIPreset
   {
      public static const MAX_RULES:int = 3;
      
      private var _window:IItemListWindow;
      
      private var UnknownVarFromTradeRuleListEditorPreset_Vector_1:Vector.<TradeRuleEditorPreset>;
      
      private var UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1:ButtonPreset;
      
      private var UnknownVarFromTradeRuleListEditorPreset_Function_1:Function;
      
      private var UnknownVarFromTradeRuleListEditorPreset_Function_2:Function;
      
      public function TradeRuleListEditorPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function, param5:Function)
      {
         super(param1,param2,param3);
         UnknownVarFromTradeRuleListEditorPreset_Function_1 = param4;
         UnknownVarFromTradeRuleListEditorPreset_Function_2 = param5;
         _window = param2.createLayout("vertical_list_view") as IItemListWindow;
         _window.spacing = param3.genericVerticalSpacing;
         UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1 = param2.createButton("${wiredcontracts.payment_add_more}",onAddMore);
         UnknownVarFromTradeRuleListEditorPreset_Vector_1 = new Vector.<TradeRuleEditorPreset>();
         _window.addListItem(UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1.window);
         refreshAddMoreVisibility();
      }
      
      public function set rules(param1:Vector.<TradeRequirementRule>) : void
      {
         var _loc2_:TradeRuleEditorPreset = null;
         removeAllRules();
         if(param1.length == 0)
         {
            param1 = new Vector.<TradeRequirementRule>();
            param1.push(new TradeRequirementRule(new Vector.<TradeRequirementNode>()));
         }
         var _loc3_:int = 1;
         for each(var _loc4_ in param1)
         {
            _loc2_ = UnknownVarFromWiredUIPreset_PresetManager_1.createRuleEditorPreset("-",UnknownVarFromTradeRuleListEditorPreset_Function_1,UnknownVarFromTradeRuleListEditorPreset_Function_2,_loc3_ == 1 ? null : onRuleRemoved);
            _loc2_.rule = _loc4_.deepCopy();
            UnknownVarFromTradeRuleListEditorPreset_Vector_1.push(_loc2_);
            _window.addListItemAt(_loc2_.window,_window.numListItems - 1);
            _loc2_.resizeToWidth(_window.width);
            _loc3_ += 1;
         }
         fixNames();
         refreshAddMoreVisibility();
      }
      
      public function finalizeRules() : Vector.<TradeRequirementRule>
      {
         var _loc1_:TradeRequirementRule = null;
         var _loc2_:Vector.<TradeRequirementRule> = new Vector.<TradeRequirementRule>();
         for each(var _loc3_ in UnknownVarFromTradeRuleListEditorPreset_Vector_1)
         {
            _loc1_ = _loc3_.finalizeRule();
            if(_loc1_.nodes.length > 0)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function onAddMore() : void
      {
         var _loc3_:int = _window.numListItems;
         var _loc2_:TradeRequirementRule = new TradeRequirementRule(new Vector.<TradeRequirementNode>());
         var _loc1_:TradeRuleEditorPreset = UnknownVarFromWiredUIPreset_PresetManager_1.createRuleEditorPreset("",UnknownVarFromTradeRuleListEditorPreset_Function_1,UnknownVarFromTradeRuleListEditorPreset_Function_2,_loc3_ == 1 ? null : onRuleRemoved);
         _loc1_.rule = _loc2_;
         UnknownVarFromTradeRuleListEditorPreset_Vector_1.push(_loc1_);
         _window.addListItemAt(_loc1_.window,_loc3_ - 1);
         _loc1_.resizeToWidth(_window.width);
         fixNames();
         refreshAddMoreVisibility();
      }
      
      private function refreshAddMoreVisibility() : void
      {
         UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1.disabled = UnknownVarFromTradeRuleListEditorPreset_Vector_1.length >= 3;
      }
      
      private function onRuleRemoved(param1:TradeRuleEditorPreset) : void
      {
         var _loc2_:int = int(UnknownVarFromTradeRuleListEditorPreset_Vector_1.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         _window.removeListItemAt(_loc2_);
         UnknownVarFromTradeRuleListEditorPreset_Vector_1.removeAt(_loc2_);
         param1.dispose();
         fixNames();
         refreshAddMoreVisibility();
      }
      
      private function removeAllRules() : void
      {
         while(_window.numListItems > 1)
         {
            _window.removeListItemAt(0);
         }
         for each(var _loc1_ in UnknownVarFromTradeRuleListEditorPreset_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromTradeRuleListEditorPreset_Vector_1 = new Vector.<TradeRuleEditorPreset>();
         refreshAddMoreVisibility();
      }
      
      private function fixNames() : void
      {
         var _loc3_:String = null;
         var _loc1_:int = 0;
         for each(var _loc2_ in UnknownVarFromTradeRuleListEditorPreset_Vector_1)
         {
            _loc1_++;
            _loc3_ = localizations.getLocalizationWithParams("wiredcontracts.payment_rule","","i",_loc1_);
            _loc2_.updateTitle(_loc3_);
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
         for each(var _loc2_ in UnknownVarFromTradeRuleListEditorPreset_Vector_1)
         {
            _loc2_.resizeToWidth(param1);
         }
         UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in UnknownVarFromTradeRuleListEditorPreset_Vector_1)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.push(UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1);
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromTradeRuleListEditorPreset_Vector_1 = null;
         UnknownVarFromTradeRuleListEditorPreset_ButtonPreset_1 = null;
         UnknownVarFromTradeRuleListEditorPreset_Function_1 = null;
         UnknownVarFromTradeRuleListEditorPreset_Function_2 = null;
         _window.dispose();
         _window = null;
      }
   }
}

