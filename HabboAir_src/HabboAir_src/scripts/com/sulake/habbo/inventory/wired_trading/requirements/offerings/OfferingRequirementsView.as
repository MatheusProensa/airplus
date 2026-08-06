package com.sulake.habbo.inventory.wired_trading.requirements.offerings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.inventory.wired_trading.requirements.WiredTradeRequirementsModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class OfferingRequirementsView implements IComponentInterfaceQueue
   {
      public static var TYPE_GIVE:int = 0;
      
      public static var TYPE_RECEIVE:int = 1;
      
      public static const RULE_VIEW_POOL:Vector.<OfferingRuleView> = new Vector.<OfferingRuleView>(0);
      
      private var _disposed:Boolean;
      
      private var _tradeRequirementsModel:WiredTradeRequirementsModel;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromOfferingRequirementsView_Int_1:int;
      
      private var UnknownVarFromOfferingRequirementsView_Int_2:int;
      
      private var _requirementTemplate:IWindowController_1;
      
      private var _rules:Vector.<TradeRequirementRule>;
      
      private var _text:String;
      
      private var _canMinimalizeWidth:Boolean;
      
      private var UnknownVarFromOfferingRequirementsView_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromOfferingRequirementsView_Vector_1:Vector.<OfferingRuleView>;
      
      public function OfferingRequirementsView(param1:IWindowController_1)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         _requirementTemplate = rulesList.removeListItemAt(0) as IWindowController_1;
      }
      
      private static function claimRuleView(param1:IWindowController_1) : OfferingRuleView
      {
         var _loc2_:OfferingRuleView = null;
         if(RULE_VIEW_POOL.length > 0)
         {
            _loc2_ = RULE_VIEW_POOL.pop();
         }
         else
         {
            _loc2_ = new OfferingRuleView(param1);
         }
         return _loc2_;
      }
      
      private static function releaseRuleView(param1:OfferingRuleView) : void
      {
         param1.recycle();
         RULE_VIEW_POOL.push(param1);
      }
      
      public function initialize(param1:WiredTradeRequirementsModel, param2:int, param3:Vector.<TradeRequirementRule>, param4:String, param5:int) : void
      {
         var _loc7_:int = 0;
         var _loc8_:TradeRequirementRule = null;
         var _loc6_:OfferingRuleView = null;
         _tradeRequirementsModel = param1;
         UnknownVarFromOfferingRequirementsView_Int_1 = param2;
         _rules = param3;
         _text = param4;
         UnknownVarFromOfferingRequirementsView_Int_2 = param5;
         UnknownVarFromOfferingRequirementsView_Vector_1 = new Vector.<OfferingRuleView>();
         if(param3 != null)
         {
            _loc7_ = 0;
            while(_loc7_ < param3.length)
            {
               _loc8_ = param3[_loc7_];
               _loc6_ = claimRuleView(_requirementTemplate);
               _loc6_.initialize(param1,this,_loc8_,_loc7_);
               UnknownVarFromOfferingRequirementsView_Vector_1.push(_loc6_);
               _loc7_ += 1;
            }
         }
         initializeUI();
      }
      
      public function recycle() : void
      {
         _tradeRequirementsModel = null;
         UnknownVarFromOfferingRequirementsView_Int_1 = 0;
         _rules = null;
         _text = null;
         UnknownVarFromOfferingRequirementsView_Int_2 = 0;
         for each(var _loc1_ in UnknownVarFromOfferingRequirementsView_Vector_1)
         {
            if(_loc1_.window.parent != null)
            {
               (_loc1_.window.parent as IWindowController_1).removeChild(_loc1_.window);
            }
            releaseRuleView(_loc1_);
         }
         UnknownVarFromOfferingRequirementsView_Vector_1 = null;
         rulesList.removeListItems();
      }
      
      private function initializeUI() : void
      {
         rulesList.visible = false;
         customText.visible = false;
         anyAllText.visible = false;
         anyCoinsText.visible = false;
         anyFurniText.visible = false;
         _canMinimalizeWidth = false;
         UnknownVarFromOfferingRequirementsView_IWindowModel_1 = null;
         if(UnknownVarFromOfferingRequirementsView_Int_1 != TradeRequirement.UnknownVarFromTradeRequirement_Int_4 && UnknownVarFromOfferingRequirementsView_Int_2 == TYPE_GIVE)
         {
            if(UnknownVarFromOfferingRequirementsView_Int_1 == TradeRequirement.UnknownVarFromTradeRequirement_Int_1)
            {
               anyCoinsText.visible = true;
               UnknownVarFromOfferingRequirementsView_IWindowModel_1 = anyCoinsText;
            }
            else if(UnknownVarFromOfferingRequirementsView_Int_1 == TradeRequirement.UnknownVarFromTradeRequirement_Int_2)
            {
               anyFurniText.visible = true;
               UnknownVarFromOfferingRequirementsView_IWindowModel_1 = anyFurniText;
            }
            else if(UnknownVarFromOfferingRequirementsView_Int_1 == TradeRequirement.UnknownVarFromTradeRequirement_Int_3)
            {
               anyAllText.visible = true;
               UnknownVarFromOfferingRequirementsView_IWindowModel_1 = anyAllText;
            }
         }
         else
         {
            if(_rules != null && _rules.length > 0)
            {
               rulesList.visible = true;
               UnknownVarFromOfferingRequirementsView_IWindowModel_1 = rulesList;
               for each(var _loc1_ in UnknownVarFromOfferingRequirementsView_Vector_1)
               {
                  rulesList.addListItem(_loc1_.window);
               }
               _canMinimalizeWidth = true;
               for each(var _loc2_ in _rules)
               {
                  if(_loc2_.nodes.length != 1)
                  {
                     _canMinimalizeWidth = false;
                     break;
                  }
               }
            }
            if(!rulesList.visible && _text != null && _text.length > 0)
            {
               customText.visible = true;
               customText.text = _text;
               UnknownVarFromOfferingRequirementsView_IWindowModel_1 = customText;
               if(customText.textWidth <= 100)
               {
                  _canMinimalizeWidth = true;
               }
            }
         }
         title.text = UnknownVarFromOfferingRequirementsView_Int_2 == TYPE_GIVE ? localization.getLocalization("inventory.wired_trading.requirements.offering") : localization.getLocalization("inventory.wired_trading.requirements.receiving");
         centerActiveElement();
      }
      
      public function get canMinimalizeWidth() : Boolean
      {
         return _canMinimalizeWidth;
      }
      
      public function get minBorderHeight() : int
      {
         if(UnknownVarFromOfferingRequirementsView_IWindowModel_1 == null)
         {
            return 0;
         }
         return UnknownVarFromOfferingRequirementsView_IWindowModel_1.height;
      }
      
      public function centerActiveElement() : void
      {
         if(UnknownVarFromOfferingRequirementsView_IWindowModel_1 == null)
         {
            return;
         }
         UnknownVarFromOfferingRequirementsView_IWindowModel_1.y = requirementsBorder.height / 2 - UnknownVarFromOfferingRequirementsView_IWindowModel_1.height / 2;
         if(UnknownVarFromOfferingRequirementsView_Int_1 == TradeRequirement.UnknownVarFromTradeRequirement_Int_4 && UnknownVarFromOfferingRequirementsView_Vector_1 != null && UnknownVarFromOfferingRequirementsView_Vector_1.length == 1)
         {
            UnknownVarFromOfferingRequirementsView_Vector_1[0].center(requirementsBorder.width - rulesList.x * 2);
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _tradeRequirementsModel.tradingModel.localization;
      }
      
      public function get tradeRequirementsModel() : WiredTradeRequirementsModel
      {
         return _tradeRequirementsModel;
      }
      
      public function get requirementTemplate() : IWindowController_1
      {
         return _requirementTemplate;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         rulesList.removeListItems();
         for each(var _loc1_ in UnknownVarFromOfferingRequirementsView_Vector_1)
         {
            releaseRuleView(_loc1_);
         }
         UnknownVarFromOfferingRequirementsView_Vector_1 = null;
         _tradeRequirementsModel = null;
         _window.dispose();
         _window = null;
         UnknownVarFromOfferingRequirementsView_Int_1 = 0;
         _requirementTemplate.dispose();
         _requirementTemplate = null;
         _rules = null;
         _text = null;
         UnknownVarFromOfferingRequirementsView_Int_2 = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get title() : ITextWindow
      {
         return _window.findChildByName("offerings_title") as ITextWindow;
      }
      
      private function get requirementsBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("requirements_definition") as UnknownICoreWindowComponents6;
      }
      
      private function get rulesList() : IItemListWindow
      {
         return _window.findChildByName("rules_list") as IItemListWindow;
      }
      
      private function get customText() : ITextWindow
      {
         return _window.findChildByName("custom_text") as ITextWindow;
      }
      
      private function get anyFurniText() : ITextWindow
      {
         return _window.findChildByName("any_furni_text") as ITextWindow;
      }
      
      private function get anyCoinsText() : ITextWindow
      {
         return _window.findChildByName("any_coins_text") as ITextWindow;
      }
      
      private function get anyAllText() : ITextWindow
      {
         return _window.findChildByName("any_all_text") as ITextWindow;
      }
   }
}

