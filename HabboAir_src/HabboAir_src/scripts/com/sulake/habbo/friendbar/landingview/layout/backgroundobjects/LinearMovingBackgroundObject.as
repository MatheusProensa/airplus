package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class LinearMovingBackgroundObject extends BackgroundObject
   {
      private var UnknownVarFromLinearMovingBackgroundObject_Int_1:int;
      
      private var UnknownVarFromLinearMovingBackgroundObject_Int_2:int;
      
      private var UnknownVarFromLinearMovingBackgroundObject_Number_1:Number;
      
      private var UnknownVarFromLinearMovingBackgroundObject_Number_2:Number;
      
      private var UnknownVarFromLinearMovingBackgroundObject_Number_3:Number;
      
      private var UnknownVarFromLinearMovingBackgroundObject_Number_4:Number;
      
      public function LinearMovingBackgroundObject(param1:int, param2:IWindowController_1, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc7_:Array = param5.split(";");
         var _loc6_:String = _loc7_[0];
         UnknownVarFromLinearMovingBackgroundObject_Int_1 = int(_loc7_[2]);
         UnknownVarFromLinearMovingBackgroundObject_Int_2 = int(_loc7_[3]);
         UnknownVarFromLinearMovingBackgroundObject_Number_3 = Number(_loc7_[4]);
         UnknownVarFromLinearMovingBackgroundObject_Number_4 = Number(_loc7_[5]);
         UnknownVarFromLinearMovingBackgroundObject_Number_1 = UnknownVarFromLinearMovingBackgroundObject_Int_1;
         UnknownVarFromLinearMovingBackgroundObject_Number_2 = UnknownVarFromLinearMovingBackgroundObject_Int_2;
         sprite.assetUri = "${image.library.url}reception/" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         if(!sprite)
         {
            return;
         }
         var _loc3_:int = window.width;
         var _loc2_:int = window.height;
         UnknownVarFromLinearMovingBackgroundObject_Number_1 += param1 * UnknownVarFromLinearMovingBackgroundObject_Number_3;
         UnknownVarFromLinearMovingBackgroundObject_Number_2 += param1 * UnknownVarFromLinearMovingBackgroundObject_Number_4;
         sprite.x = UnknownVarFromLinearMovingBackgroundObject_Number_1;
         sprite.y = UnknownVarFromLinearMovingBackgroundObject_Number_2 + window.desktop.height;
         if(UnknownVarFromLinearMovingBackgroundObject_Number_3 > 0 && sprite.x > _loc3_ || UnknownVarFromLinearMovingBackgroundObject_Number_3 < 0 && sprite.x + sprite.width < 0 || UnknownVarFromLinearMovingBackgroundObject_Number_4 > 0 && sprite.y > _loc2_ || UnknownVarFromLinearMovingBackgroundObject_Number_4 < 0 && sprite.y + sprite.height < 0)
         {
            UnknownVarFromLinearMovingBackgroundObject_Number_1 = UnknownVarFromLinearMovingBackgroundObject_Int_1;
            UnknownVarFromLinearMovingBackgroundObject_Number_2 = UnknownVarFromLinearMovingBackgroundObject_Int_2;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
      }
   }
}

