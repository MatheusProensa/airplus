package com.sulake.habbo.catalog.recycler
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.IProductGridItem;
   import com.sulake.habbo.catalog.viewer.ProductGridItem;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class PrizeGridItem extends ProductGridItem implements UnknownIHabboRoom1, IProductGridItem
   {
      public function PrizeGridItem(param1:HabboCatalog)
      {
         super(param1);
      }
      
      protected function initProductIcon(param1:IRoomEngine, param2:String, param3:int, param4:String = "") : void
      {
         var _loc5_:UnknownHabboRoom1 = null;
         var _loc7_:BitmapData = null;
         var _loc6_:BitmapData = null;
         switch(param2)
         {
            case "s":
               _loc5_ = param1.getFurnitureIcon(param3,this);
               break;
            case "i":
               _loc5_ = param1.getWallItemIcon(param3,this,param4);
               break;
            case "chat_style":
               _loc7_ = catalog.freeFlowChat.chatStyleLibrary.getStyle(param3).selectorPreview.clone();
               _loc6_ = new BitmapData(_loc7_.width / 2,_loc7_.height / 2,true,0);
               _loc6_.draw(_loc7_,new Matrix(0.5,0,0,0.5),null,null,null,true);
               break;
            default:
               Logger.log("[PrizeItemContainer] Can not yet handle this type of product: " + param2);
               return;
         }
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.data;
         }
         if(_loc6_ != null)
         {
            setIconImage(_loc6_,true);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         setIconImage(param2,true);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

