package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class BundleProductContainer extends ProductContainer implements IItemGrid
   {
      private var UnknownVarFromBundleProductContainer_BitmapData_1:BitmapData;
      
      public function BundleProductContainer(param1:UnknownIHabboCatalog1, param2:Vector.<IProduct>, param3:HabboCatalog)
      {
         super(param1,param2,param3);
         var _loc4_:BitmapDataAsset = param3.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset;
         if(_loc4_ != null)
         {
            UnknownVarFromBundleProductContainer_BitmapData_1 = _loc4_.content as BitmapData;
         }
         else
         {
            UnknownVarFromBundleProductContainer_BitmapData_1 = new BitmapData(1,1,true,16777215);
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromBundleProductContainer_BitmapData_1 = null;
         super.dispose();
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         setIconImage(UnknownVarFromBundleProductContainer_BitmapData_1.clone(),true);
      }
      
      public function populateItemGrid(param1:IItemGridWindow, param2:XML) : void
      {
         var _loc7_:IWindowController_1 = null;
         var _loc3_:IWindowModel = null;
         var _loc6_:BitmapData = null;
         var _loc4_:IWindowController_1 = catalog.windowManager.buildFromXML(param2) as IWindowController_1;
         for each(var _loc5_ in offer.productContainer.products)
         {
            if(_loc5_.productType != "b")
            {
               _loc7_ = _loc4_.clone() as IWindowController_1;
               _loc3_ = _loc7_.findChildByName("clubLevelIcon");
               if(_loc3_ != null)
               {
                  _loc3_.visible = false;
               }
               param1.addGridItem(_loc7_);
               _loc5_.view = _loc7_;
               _loc6_ = _loc5_.initIcon(this);
               if(_loc6_ != null)
               {
                  _loc6_.dispose();
               }
               _loc5_.grid = this;
            }
         }
      }
      
      public function setBundleCounter(param1:int) : void
      {
         var _loc2_:IWindowModel = _view.findChildByName("bundleCounter") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.caption = param1.toString();
         }
      }
      
      public function select(param1:IProductGridItem, param2:Boolean) : void
      {
         Logger.log("Product Bundle, select item: " + param1);
      }
      
      public function startDragAndDrop(param1:IProductGridItem) : Boolean
      {
         return false;
      }
      
      override public function set view(param1:IWindowController_1) : void
      {
         super.view = param1;
         setBundleCounter(999);
      }
   }
}

