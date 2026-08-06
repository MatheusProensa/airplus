package com.sulake.habbo.catalog.recycler
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.parser.recycler.PrizeMessageSubProduct;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class DealPrizeContainer extends PrizeContainer
   {
      private var _subProducts:Array;
      
      private var _furnitureDatas:Array;
      
      private var _catalog:HabboCatalog;
      
      private var _gridItemLayout:XML;
      
      private var UnknownVarFromDealPrizeContainer_BitmapData_1:BitmapData;
      
      public function DealPrizeContainer(param1:Array, param2:int, param3:HabboCatalog)
      {
         var _loc6_:int = 0;
         var _loc4_:PrizeMessageSubProduct = null;
         var _loc7_:IFurnitureData = null;
         _furnitureDatas = [];
         _catalog = param3;
         _subProducts = param1;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_];
            _loc7_ = param3.getFurnitureData(_loc4_.productItemTypeId,_loc4_.productItemType);
            _furnitureDatas.push(_loc7_);
            _loc6_++;
         }
         var _loc8_:XmlAsset = param3.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc8_.content as XML;
         var _loc5_:BitmapDataAsset = param3.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset;
         UnknownVarFromDealPrizeContainer_BitmapData_1 = BitmapData(_loc5_.content);
         super("deal",-1,null,param2,param3);
      }
      
      override public function setIcon(param1:IRoomEngine) : void
      {
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(view.findChildByName("image"));
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc2_.bitmap.copyPixels(UnknownVarFromDealPrizeContainer_BitmapData_1,UnknownVarFromDealPrizeContainer_BitmapData_1.rect,new Point((_loc2_.width - UnknownVarFromDealPrizeContainer_BitmapData_1.width) / 2,(_loc2_.height - UnknownVarFromDealPrizeContainer_BitmapData_1.height) / 2));
         ITextWindow(view.findChildByName("bundleCounter")).text = _subProducts.length.toString();
      }
      
      override public function get title() : String
      {
         return "";
      }
      
      public function get subProducts() : Array
      {
         return _subProducts;
      }
      
      public function get furnitureDatas() : Array
      {
         return _furnitureDatas;
      }
   }
}

