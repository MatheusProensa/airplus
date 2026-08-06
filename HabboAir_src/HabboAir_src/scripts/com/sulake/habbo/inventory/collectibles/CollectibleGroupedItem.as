package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftItem;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class CollectibleGroupedItem
   {
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var _isInitialized:Boolean = false;
      
      private var _renderableItem:RenderableTradeNftItem;
      
      private var UnknownVarFromCollectibleGroupedItem_Map_1:Map;
      
      private var _isSelected:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromCollectibleGroupedItem_IWindowModel_1:IWindowModel;
      
      private var _isUnseen:Boolean;
      
      private var UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1:CollectiblesModel;
      
      private var _name:String;
      
      public function CollectibleGroupedItem(param1:TradeNftItem, param2:Vector.<Number>, param3:CollectiblesModel)
      {
         super();
         _renderableItem = new RenderableTradeNftItem(param1);
         UnknownVarFromCollectibleGroupedItem_Map_1 = new Map();
         for each(var _loc4_ in param2)
         {
            UnknownVarFromCollectibleGroupedItem_Map_1.add(_loc4_,false);
         }
         UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1 = param3;
         _isUnseen = false;
         this.isSelected = false;
         var _loc5_:XmlAsset = UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1.controller.assets.getAssetByName("inventory_thumb_nft_xml") as XmlAsset;
         if(_loc5_ == null || _loc5_.content == null)
         {
            return;
         }
         _window = UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1.controller.windowManager.buildFromXML(_loc5_.content as XML) as IWindowController_1;
         _window.procedure = itemEventProc;
         UnknownVarFromCollectibleGroupedItem_IWindowModel_1 = _window.findChildByTag("BG_COLOR");
         _name = UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1.controller.catalog.collectorHub.getProductName(_renderableItem);
         unlockedAssetCountChanged();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function initializeImage() : void
      {
         (nftIconWidget.widget as IProductIconWidget).productInfo = _renderableItem;
         _isInitialized = true;
      }
      
      public function get isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      public function get item() : TradeNftItem
      {
         return _renderableItem.item;
      }
      
      public function addAssetId(param1:Number) : void
      {
         UnknownVarFromCollectibleGroupedItem_Map_1.add(param1,false);
         unlockedAssetCountChanged();
      }
      
      public function get assetIds() : Array
      {
         return UnknownVarFromCollectibleGroupedItem_Map_1.getKeys();
      }
      
      public function pop(param1:int) : Vector.<Number>
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<Number> = new Vector.<Number>();
         for each(var _loc4_ in UnknownVarFromCollectibleGroupedItem_Map_1.getKeys())
         {
            _loc2_ = UnknownVarFromCollectibleGroupedItem_Map_1.getValue(_loc4_);
            if(!_loc2_)
            {
               _loc3_.push(_loc4_);
            }
            if(_loc3_.length >= param1)
            {
               break;
            }
         }
         return _loc3_;
      }
      
      public function removeAssetId(param1:Number) : Boolean
      {
         if(UnknownVarFromCollectibleGroupedItem_Map_1.hasKey(param1))
         {
            UnknownVarFromCollectibleGroupedItem_Map_1.remove(param1);
            unlockedAssetCountChanged();
            return true;
         }
         return false;
      }
      
      public function hasAsset(param1:Number, param2:Boolean = false) : Boolean
      {
         var _loc3_:Boolean = false;
         if(UnknownVarFromCollectibleGroupedItem_Map_1.hasKey(param1))
         {
            _loc3_ = UnknownVarFromCollectibleGroupedItem_Map_1.getValue(param1);
            return _loc3_ == param2;
         }
         return false;
      }
      
      public function lockAsset(param1:Number, param2:Boolean = false) : Boolean
      {
         if(!UnknownVarFromCollectibleGroupedItem_Map_1.hasKey(param1))
         {
            return false;
         }
         var _loc3_:Boolean = UnknownVarFromCollectibleGroupedItem_Map_1.getValue(param1);
         if(_loc3_ && param2)
         {
            UnknownVarFromCollectibleGroupedItem_Map_1.remove(param1);
            UnknownVarFromCollectibleGroupedItem_Map_1.add(param1,false);
            unlockedAssetCountChanged();
            return true;
         }
         if(!_loc3_ && !param2)
         {
            UnknownVarFromCollectibleGroupedItem_Map_1.remove(param1);
            UnknownVarFromCollectibleGroupedItem_Map_1.add(param1,true);
            unlockedAssetCountChanged();
            return true;
         }
         return false;
      }
      
      public function unlockAll() : void
      {
         var _loc2_:Boolean = false;
         for each(var _loc1_ in UnknownVarFromCollectibleGroupedItem_Map_1.getKeys())
         {
            if(UnknownVarFromCollectibleGroupedItem_Map_1.getValue(_loc1_))
            {
               UnknownVarFromCollectibleGroupedItem_Map_1.remove(_loc1_);
               UnknownVarFromCollectibleGroupedItem_Map_1.add(_loc1_,false);
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            unlockedAssetCountChanged();
         }
      }
      
      public function get amount() : int
      {
         return UnknownVarFromCollectibleGroupedItem_Map_1.length;
      }
      
      private function unlockedAssetCountChanged() : void
      {
         var _loc2_:int = unlockedAssetCount;
         numberContainer.visible = _loc2_ > 1;
         numberText.caption = String(_loc2_);
         var _loc1_:Number = _loc2_ == 0 ? 0.2 : 1;
         (nftIconWidget.widget as IProductIconWidget).blend = _loc1_;
      }
      
      public function get unlockedAssetCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in UnknownVarFromCollectibleGroupedItem_Map_1.getValues())
         {
            if(!_loc2_)
            {
               _loc1_ += 1;
            }
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         if(_isSelected)
         {
            UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1.setSelected(null);
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function itemEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1.setSelected(this);
               break;
            case "WME_DOUBLE_CLICK":
               UnknownVarFromCollectibleGroupedItem_CollectiblesModel_1.requestAddTrading(this,1);
         }
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(UnknownVarFromCollectibleGroupedItem_IWindowModel_1 == null || _window == null)
         {
            return;
         }
         UnknownVarFromCollectibleGroupedItem_IWindowModel_1.color = _isUnseen ? 10275685 : 13421772;
         _window.findChildByName("outline").visible = param1;
      }
      
      public function set isUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            this.isSelected = _isSelected;
         }
      }
      
      public function removeIntervalProcedure() : void
      {
         if(_window)
         {
            _window.procedure = null;
         }
      }
      
      protected function get nftIconWidget() : IWidgetWindowController
      {
         return _window.findChildByName("nft_icon") as IWidgetWindowController;
      }
      
      protected function get numberContainer() : IWindowController_1
      {
         return _window.findChildByName("number_container") as IWindowController_1;
      }
      
      protected function get numberText() : ITextWindow
      {
         return _window.findChildByName("number") as ITextWindow;
      }
      
      public function get renderableItem() : RenderableTradeNftItem
      {
         return _renderableItem;
      }
   }
}

