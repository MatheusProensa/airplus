package com.sulake.habbo.roomevents.wired_trading.transactions.details.furni_overview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.roomevents.wired_trading.transactions.details.*;
   
   public class TransactionOverviewView implements IComponentInterfaceQueue
   {
      private static var ITEM_POOL_MAX_SIZE:int = 15;
      
      private var UnknownVarFromTransactionOverviewView_Vector_1:Vector.<TransactionItemView> = new Vector.<TransactionItemView>();
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromTransactionOverviewView_WiredTransactionDetailsController_1:WiredTransactionDetailsController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromTransactionOverviewView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromTransactionOverviewView_Vector_2:Vector.<TransactionItemView>;
      
      public function TransactionOverviewView(param1:WiredTransactionDetailsController, param2:IWindowController_1)
      {
         super();
         UnknownVarFromTransactionOverviewView_WiredTransactionDetailsController_1 = param1;
         _window = param2;
         UnknownVarFromTransactionOverviewView_IRegionWindow_1 = itemGrid.removeGridItemAt(0) as IRegionWindow;
      }
      
      public function clear() : void
      {
         itemGrid.removeGridItems();
         for each(var _loc1_ in UnknownVarFromTransactionOverviewView_Vector_2)
         {
            recycleView(_loc1_);
         }
         UnknownVarFromTransactionOverviewView_Vector_2 = new Vector.<TransactionItemView>();
      }
      
      public function itemsInitialize(param1:int, param2:Map, param3:int, param4:Boolean) : void
      {
         var _loc9_:TransactionItemView = null;
         var _loc6_:int = 0;
         var _loc7_:TransactionItemView = null;
         var _loc12_:int = 0;
         var _loc8_:TransactionItemView = null;
         clear();
         var _loc10_:Vector.<TransactionItemView> = new Vector.<TransactionItemView>();
         if(param1 != 0)
         {
            _loc9_ = claimView(param1,1);
            _loc10_.push(_loc9_);
         }
         var _loc11_:int = 0;
         for each(var _loc5_ in param2.getKeys())
         {
            _loc6_ = int(param2[_loc5_]);
            _loc7_ = claimView(param2.getValue(_loc5_),0,_loc5_);
            _loc11_ += _loc6_;
            if(_loc7_ != null)
            {
               _loc10_.push(_loc7_);
            }
         }
         if(param4 && _loc11_ < param3)
         {
            _loc12_ = param3 - _loc11_;
            _loc8_ = claimView(_loc12_,2);
            _loc10_.push(_loc8_);
         }
         UnknownVarFromTransactionOverviewView_Vector_2 = _loc10_;
         updateGrid();
      }
      
      public function updateGrid() : void
      {
         var _loc1_:int = 0;
         itemGrid.removeGridItems();
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromTransactionOverviewView_Vector_2.length)
         {
            itemGrid.addGridItem(UnknownVarFromTransactionOverviewView_Vector_2[_loc1_].window);
            _loc1_++;
         }
         emptyText.visible = itemGrid.numGridItems == 0;
      }
      
      private function claimView(param1:int, param2:int, param3:ChestItemType = null) : TransactionItemView
      {
         var _loc4_:TransactionItemView = null;
         if(UnknownVarFromTransactionOverviewView_Vector_1.length > 0)
         {
            _loc4_ = UnknownVarFromTransactionOverviewView_Vector_1.pop();
         }
         else
         {
            _loc4_ = new TransactionItemView(UnknownVarFromTransactionOverviewView_IRegionWindow_1,UnknownVarFromTransactionOverviewView_WiredTransactionDetailsController_1);
         }
         _loc4_.initialize(param1,param2,param3);
         return _loc4_;
      }
      
      private function recycleView(param1:TransactionItemView) : void
      {
         if(UnknownVarFromTransactionOverviewView_Vector_1.length < ITEM_POOL_MAX_SIZE)
         {
            param1.recycle();
            UnknownVarFromTransactionOverviewView_Vector_1.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window = null;
         UnknownVarFromTransactionOverviewView_IRegionWindow_1.dispose();
         UnknownVarFromTransactionOverviewView_IRegionWindow_1 = null;
         for each(var _loc2_ in UnknownVarFromTransactionOverviewView_Vector_2)
         {
            recycleView(_loc2_);
         }
         UnknownVarFromTransactionOverviewView_Vector_2 = null;
         for each(var _loc1_ in UnknownVarFromTransactionOverviewView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromTransactionOverviewView_Vector_1 = null;
         UnknownVarFromTransactionOverviewView_WiredTransactionDetailsController_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get itemGrid() : IScrollableGridWindow
      {
         return _window.findChildByName("item_grid") as IScrollableGridWindow;
      }
      
      private function get emptyText() : ITextWindow
      {
         return _window.findChildByName("empty_text") as ITextWindow;
      }
   }
}

