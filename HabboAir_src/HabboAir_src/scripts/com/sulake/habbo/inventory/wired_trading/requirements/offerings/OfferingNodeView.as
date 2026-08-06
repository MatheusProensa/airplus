package com.sulake.habbo.inventory.wired_trading.requirements.offerings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.inventory.wired_trading.requirements.WiredTradeRequirementsModel;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class OfferingNodeView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromOfferingNodeView_WiredTradeRequirementsModel_1:WiredTradeRequirementsModel;
      
      private var UnknownVarFromOfferingNodeView_OfferingRuleView_1:OfferingRuleView;
      
      private var _window:IItemListWindow;
      
      private var _ruleNode:TradeRequirementNode;
      
      private var UnknownVarFromOfferingNodeView_Int_1:int;
      
      public function OfferingNodeView(param1:IItemListWindow)
      {
         super();
         _window = param1.clone() as IItemListWindow;
      }
      
      public function initialize(param1:WiredTradeRequirementsModel, param2:OfferingRuleView, param3:TradeRequirementNode, param4:int) : void
      {
         UnknownVarFromOfferingNodeView_WiredTradeRequirementsModel_1 = param1;
         UnknownVarFromOfferingNodeView_OfferingRuleView_1 = param2;
         _ruleNode = param3;
         UnknownVarFromOfferingNodeView_Int_1 = param4;
         initializeUI();
      }
      
      public function recycle() : void
      {
         UnknownVarFromOfferingNodeView_WiredTradeRequirementsModel_1 = null;
         UnknownVarFromOfferingNodeView_OfferingRuleView_1 = null;
         _ruleNode = null;
         UnknownVarFromOfferingNodeView_Int_1 = 0;
      }
      
      private function initializeUI() : void
      {
         var _loc1_:IProductIconWidget = null;
         furniIcon.visible = _ruleNode.type == TradeRequirementNode.TYPE_FURNI;
         coinIcon.visible = _ruleNode.type == TradeRequirementNode.TYPE_COIN;
         andText.visible = UnknownVarFromOfferingNodeView_Int_1 > 0;
         amountText.visible = _ruleNode.amount > 1;
         if(_ruleNode.amount > 1)
         {
            amountText.text = _ruleNode.amount + "x";
         }
         if(_ruleNode.type == TradeRequirementNode.TYPE_FURNI)
         {
            _loc1_ = furniIcon.widget as IProductIconWidget;
            _loc1_.productInfo = new ChestItemTypeRenderableWrapper(_ruleNode.itemType);
         }
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromOfferingNodeView_WiredTradeRequirementsModel_1 = null;
         UnknownVarFromOfferingNodeView_OfferingRuleView_1 = null;
         _window.dispose();
         _window = null;
         _ruleNode = null;
         UnknownVarFromOfferingNodeView_Int_1 = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get andText() : ITextWindow
      {
         return _window.findChildByName("and_text") as ITextWindow;
      }
      
      private function get amountText() : ITextWindow
      {
         return _window.findChildByName("amount_text") as ITextWindow;
      }
      
      private function get ruleIcon() : IWindowController_1
      {
         return _window.findChildByName("rule_icon") as IWindowController_1;
      }
      
      private function get furniIcon() : IWidgetWindowController
      {
         return _window.findChildByName("furni_icon") as IWidgetWindowController;
      }
      
      private function get coinIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("coin_icon") as IStaticBitmapWrapperWindow;
      }
   }
}

