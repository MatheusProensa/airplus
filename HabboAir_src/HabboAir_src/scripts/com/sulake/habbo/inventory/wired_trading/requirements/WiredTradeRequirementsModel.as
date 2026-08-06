package com.sulake.habbo.inventory.wired_trading.requirements
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.wired_trading.WiredTradingModel;
   
   public class WiredTradeRequirementsModel implements IComponentInterfaceQueue
   {
      private var _tradingModel:WiredTradingModel;
      
      private var _view:WiredTradeRequirementsView;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1:TradeRequirementWrapper;
      
      public function WiredTradeRequirementsModel(param1:WiredTradingModel)
      {
         super();
         _tradingModel = param1;
         _view = new WiredTradeRequirementsView(this);
      }
      
      public function get tradingModel() : WiredTradingModel
      {
         return _tradingModel;
      }
      
      public function setRequirements(param1:TradeRequirement, param2:Boolean) : void
      {
         UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1 = new TradeRequirementWrapper(param1);
         _view.requirementsUpdated(param1,param2);
      }
      
      public function requirementsStateUpdated() : void
      {
         _view.requirementsStateUpdated();
      }
      
      public function highlightRefresh() : void
      {
         _view.highlightRefresh();
      }
      
      public function get requirement() : TradeRequirement
      {
         return UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.requirements;
      }
      
      public function canOfferFurni(param1:GroupItem) : Boolean
      {
         if(UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1 == null)
         {
            return true;
         }
         if(param1.getTradeableCount(false) == 0)
         {
            return false;
         }
         if(UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.type == TradeRequirement.UnknownVarFromTradeRequirement_Int_3)
         {
            return true;
         }
         if(UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.type == TradeRequirement.UnknownVarFromTradeRequirement_Int_2)
         {
            return param1.className.indexOf("CF_") != 0;
         }
         if(UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.type == TradeRequirement.UnknownVarFromTradeRequirement_Int_1)
         {
            return param1.className.indexOf("CF_") == 0;
         }
         if(UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.type == TradeRequirement.UnknownVarFromTradeRequirement_Int_4)
         {
            if(param1.className.indexOf("CF_") == 0)
            {
               return UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.canOfferCreditFurni();
            }
            return UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1.canOfferNormalFurni(param1);
         }
         return true;
      }
      
      public function get view() : WiredTradeRequirementsView
      {
         return _view;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _view.dispose();
         _view = null;
         _tradingModel = null;
         UnknownVarFromWiredTradeRequirementsModel_TradeRequirementWrapper_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

