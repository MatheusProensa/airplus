package com.sulake.habbo.inventory.wired_trading.requirements.offerings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.inventory.wired_trading.requirements.WiredTradeRequirementsModel;
   
   public class OfferingRuleView implements IComponentInterfaceQueue
   {
      public static var MAX_COLS:int = 2;
      
      public static const NODE_VIEW_POOL:Vector.<OfferingNodeView> = new Vector.<OfferingNodeView>(0);
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromOfferingRuleView_WiredTradeRequirementsModel_1:WiredTradeRequirementsModel;
      
      private var UnknownVarFromOfferingRuleView_OfferingRequirementsView_1:OfferingRequirementsView;
      
      private var UnknownVarFromOfferingRuleView_TradeRequirementRule_1:TradeRequirementRule;
      
      private var UnknownVarFromOfferingRuleView_Int_1:int;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromOfferingRuleView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromOfferingRuleView_IItemListWindow_2:IItemListWindow;
      
      private var UnknownVarFromOfferingRuleView_Int_2:int = 0;
      
      private var _nodes:Vector.<OfferingNodeView>;
      
      public function OfferingRuleView(param1:IWindowController_1)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromOfferingRuleView_IItemListWindow_1 = rows.removeListItemAt(0) as IItemListWindow;
         UnknownVarFromOfferingRuleView_IItemListWindow_2 = UnknownVarFromOfferingRuleView_IItemListWindow_1.removeListItemAt(0) as IItemListWindow;
         UnknownVarFromOfferingRuleView_Int_2 = rows.x;
      }
      
      private static function claimNodeView(param1:IItemListWindow) : OfferingNodeView
      {
         var _loc2_:OfferingNodeView = null;
         if(NODE_VIEW_POOL.length > 0)
         {
            _loc2_ = NODE_VIEW_POOL.pop();
         }
         else
         {
            _loc2_ = new OfferingNodeView(param1);
         }
         return _loc2_;
      }
      
      private static function releaseNodeView(param1:OfferingNodeView) : void
      {
         param1.recycle();
         NODE_VIEW_POOL.push(param1);
      }
      
      public function initialize(param1:WiredTradeRequirementsModel, param2:OfferingRequirementsView, param3:TradeRequirementRule, param4:int) : void
      {
         var _loc5_:TradeRequirementNode = null;
         var _loc6_:OfferingNodeView = null;
         UnknownVarFromOfferingRuleView_WiredTradeRequirementsModel_1 = param1;
         UnknownVarFromOfferingRuleView_OfferingRequirementsView_1 = param2;
         UnknownVarFromOfferingRuleView_TradeRequirementRule_1 = param3;
         UnknownVarFromOfferingRuleView_Int_1 = param4;
         _window.width = param2.window.width;
         _nodes = new Vector.<OfferingNodeView>();
         if(param3 != null && param3.nodes != null)
         {
            param4 = 0;
            while(param4 < param3.nodes.length)
            {
               _loc5_ = param3.nodes[param4];
               _loc6_ = claimNodeView(UnknownVarFromOfferingRuleView_IItemListWindow_2);
               _loc6_.initialize(param1,this,_loc5_,param4);
               _nodes.push(_loc6_);
               param4 += 1;
            }
         }
         initializeUI();
      }
      
      public function recycle() : void
      {
         var _loc2_:IItemListWindow = null;
         UnknownVarFromOfferingRuleView_WiredTradeRequirementsModel_1 = null;
         UnknownVarFromOfferingRuleView_OfferingRequirementsView_1 = null;
         UnknownVarFromOfferingRuleView_TradeRequirementRule_1 = null;
         UnknownVarFromOfferingRuleView_Int_1 = 0;
         for each(var _loc1_ in _nodes)
         {
            if(_loc1_.window.parent != null)
            {
               _loc1_.window.parent = null;
            }
            releaseNodeView(_loc1_);
         }
         _nodes = null;
         while(rows.numListItems > 0)
         {
            _loc2_ = rows.removeListItemAt(0) as IItemListWindow;
            _loc2_.removeListItems();
            _loc2_.dispose();
         }
      }
      
      private function initializeUI() : void
      {
         rows.x = UnknownVarFromOfferingRuleView_Int_2;
         var _loc2_:IItemListWindow = null;
         for each(var _loc1_ in _nodes)
         {
            if(_loc2_ == null || _loc2_.numListItems >= MAX_COLS)
            {
               _loc2_ = UnknownVarFromOfferingRuleView_IItemListWindow_1.clone() as IItemListWindow;
               rows.addListItem(_loc2_);
            }
            _loc2_.addListItem(_loc1_.window);
         }
         orText.visible = UnknownVarFromOfferingRuleView_Int_1 > 0;
         _window.height = rows.height;
      }
      
      public function center(param1:int) : void
      {
         rows.x = param1 / 2 - colsWidth / 2;
      }
      
      private function get colsWidth() : int
      {
         var _loc2_:int = 0;
         var _loc3_:IWindowModel = null;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < rows.numListItems)
         {
            _loc3_ = rows.getListItemAt(_loc2_);
            if(_loc3_.width > _loc1_)
            {
               _loc1_ = _loc3_.width;
            }
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         rows.removeListItems();
         for each(var _loc1_ in _nodes)
         {
            releaseNodeView(_loc1_);
         }
         _nodes = null;
         UnknownVarFromOfferingRuleView_IItemListWindow_1.dispose();
         UnknownVarFromOfferingRuleView_IItemListWindow_2.dispose();
         UnknownVarFromOfferingRuleView_IItemListWindow_1 = null;
         UnknownVarFromOfferingRuleView_IItemListWindow_2 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromOfferingRuleView_TradeRequirementRule_1 = null;
         UnknownVarFromOfferingRuleView_Int_1 = 0;
         UnknownVarFromOfferingRuleView_OfferingRequirementsView_1 = null;
         UnknownVarFromOfferingRuleView_WiredTradeRequirementsModel_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get orText() : ITextWindow
      {
         return _window.findChildByName("or_text") as ITextWindow;
      }
      
      private function get rows() : IItemListWindow
      {
         return _window.findChildByName("rule_nodes_rows") as IItemListWindow;
      }
   }
}

