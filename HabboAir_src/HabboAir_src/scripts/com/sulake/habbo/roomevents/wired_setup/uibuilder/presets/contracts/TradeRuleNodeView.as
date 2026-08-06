package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views.ChestItemTypeRenderableWrapper;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class TradeRuleNodeView implements IComponentInterfaceQueue
   {
      private static var UNIQUE_ID_COUNTER:uint = 0;
      
      private var UnknownVarFromTradeRuleNodeView_TradeRuleEditorPreset_1:TradeRuleEditorPreset;
      
      private var _node:TradeRequirementNode;
      
      private var _window:IRegionWindow;
      
      private var UnknownVarFromTradeRuleNodeView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromTradeRuleNodeView_Boolean_2:Boolean = false;
      
      private var UnknownVarFromTradeRuleNodeView_Boolean_3:Boolean;
      
      private var _uniqueID:uint;
      
      private var _disposed:Boolean = false;
      
      public function TradeRuleNodeView(param1:IRegionWindow)
      {
         super();
         _uniqueID = UNIQUE_ID_COUNTER++;
         _window = param1.clone() as IRegionWindow;
         _window.addEventListener("WME_OVER",onHover);
         _window.addEventListener("WME_OUT",onHoverEnd);
         closeRegion.addEventListener("WME_OVER",onCloseHover);
         closeRegion.addEventListener("WME_OUT",onCloseHoverEnd);
         _window.addEventListener("WME_CLICK",onClick);
         closeRegion.addEventListener("WME_CLICK",onCloseClick);
      }
      
      public function initialize(param1:TradeRuleEditorPreset, param2:TradeRequirementNode, param3:Boolean = true) : void
      {
         UnknownVarFromTradeRuleNodeView_TradeRuleEditorPreset_1 = param1;
         _node = param2;
         UnknownVarFromTradeRuleNodeView_Boolean_3 = param3;
         UnknownVarFromTradeRuleNodeView_Boolean_1 = false;
         UnknownVarFromTradeRuleNodeView_Boolean_2 = false;
         Util.disableSection(_window,false);
         updateUI();
      }
      
      public function release() : void
      {
         UnknownVarFromTradeRuleNodeView_TradeRuleEditorPreset_1 = null;
         _node = null;
         UnknownVarFromTradeRuleNodeView_Boolean_3 = true;
      }
      
      private function onCloseClick(param1:WindowMouseEvent) : void
      {
         if(_node == null)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_TradeRuleEditorPreset_1.removeNode(this);
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_node == null)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_TradeRuleEditorPreset_1.editNode(this);
      }
      
      private function updateUI() : void
      {
         var _loc2_:ChestItemTypeRenderableWrapper = null;
         closeRegion.visible = UnknownVarFromTradeRuleNodeView_Boolean_3 && (UnknownVarFromTradeRuleNodeView_Boolean_1 || UnknownVarFromTradeRuleNodeView_Boolean_2);
         quantityAmount.text = String(_node.amount);
         quantityBorder.visible = _node.amount != 1 || _node.type == TradeRequirementNode.TYPE_COIN;
         var _loc1_:IProductIconWidget = iconWidget.widget as IProductIconWidget;
         if(_node.type == TradeRequirementNode.TYPE_FURNI)
         {
            iconWidget.visible = true;
            _loc2_ = null;
            if(_node.itemType != null)
            {
               _loc2_ = new ChestItemTypeRenderableWrapper(_node.itemType);
            }
            _loc1_.productInfo = _loc2_;
            coinsIcon.visible = false;
         }
         else
         {
            iconWidget.visible = false;
            _loc1_.productInfo = null;
            coinsIcon.visible = true;
         }
      }
      
      private function onHoverEnd(param1:WindowMouseEvent) : void
      {
         if(_node == null)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_Boolean_1 = false;
         updateUI();
      }
      
      private function onHover(param1:WindowMouseEvent) : void
      {
         if(_node == null)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_Boolean_1 = true;
         updateUI();
      }
      
      private function onCloseHoverEnd(param1:WindowMouseEvent) : void
      {
         if(_node == null)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_Boolean_2 = false;
         updateUI();
      }
      
      private function onCloseHover(param1:WindowMouseEvent) : void
      {
         if(_node == null)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_Boolean_2 = true;
         updateUI();
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function get node() : TradeRequirementNode
      {
         return _node;
      }
      
      public function set node(param1:TradeRequirementNode) : void
      {
         _node = param1;
         updateUI();
      }
      
      public function get uniqueID() : uint
      {
         return _uniqueID;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromTradeRuleNodeView_TradeRuleEditorPreset_1 = null;
         _node = null;
         _window.dispose();
         _window = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get iconWidget() : IWidgetWindowController
      {
         return _window.findChildByName("element_icon_widget") as IWidgetWindowController;
      }
      
      private function get coinsIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("coins_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get quantityBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("quantity_border") as UnknownICoreWindowComponents6;
      }
      
      private function get quantityAmount() : ITextWindow
      {
         return _window.findChildByName("quantity_amount") as ITextWindow;
      }
      
      private function get closeRegion() : IRegionWindow
      {
         return _window.findChildByName("close_region") as IRegionWindow;
      }
   }
}

