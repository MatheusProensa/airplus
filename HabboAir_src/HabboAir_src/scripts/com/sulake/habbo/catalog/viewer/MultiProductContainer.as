package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   
   public class MultiProductContainer extends SingleProductContainer
   {
      public function MultiProductContainer(param1:UnknownIHabboCatalog1, param2:Vector.<IProduct>, param3:HabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         super.initProductIcon(param1);
         var _loc3_:IWindowModel = _view.findChildByName("multiContainer");
         if(_loc3_)
         {
            _loc3_.visible = true;
         }
         var _loc4_:ITextWindow = _view.findChildByName("multiCounter") as ITextWindow;
         if(_loc4_)
         {
            _loc4_.text = "x" + firstProduct.productCount;
         }
         this.setClubIconLevel(offer.clubLevel);
      }
   }
}

