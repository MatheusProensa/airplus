package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import com.sulake.habbo.utils.UnknownHabboUtils1;
   import flash.events.EventDispatcher;
   
   public class RandomWalkMovingBackgroundObject extends BackgroundObject
   {
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Int_1:int;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Int_2:int;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_1:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_2:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_3:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_4:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_5:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Uint_1:uint = 0;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_6:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_7:Number;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_8:Number = 0;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_9:Number = 0;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_10:Number = 0;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Number_11:Number = 0;
      
      private var UnknownVarFromRandomWalkMovingBackgroundObject_Uint_2:uint;
      
      public function RandomWalkMovingBackgroundObject(param1:int, param2:IWindowController_1, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5,false);
         var _loc7_:Array = param5.split(";");
         var _loc6_:String = _loc7_[0];
         UnknownVarFromRandomWalkMovingBackgroundObject_Int_1 = int(_loc7_[2]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Int_2 = int(_loc7_[3]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_3 = Number(_loc7_[4]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_4 = Number(_loc7_[5]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_1 = Number(_loc7_[6]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_2 = Number(_loc7_[7]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_5 = int(_loc7_[8]);
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_6 = UnknownVarFromRandomWalkMovingBackgroundObject_Int_1;
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_7 = UnknownVarFromRandomWalkMovingBackgroundObject_Int_2;
         sprite.assetUri = "${image.library.url}" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         if(!sprite)
         {
            return;
         }
         UnknownVarFromRandomWalkMovingBackgroundObject_Uint_1 += param1;
         if(UnknownVarFromRandomWalkMovingBackgroundObject_Uint_1 - UnknownVarFromRandomWalkMovingBackgroundObject_Uint_2 > UnknownVarFromRandomWalkMovingBackgroundObject_Number_5)
         {
            UnknownVarFromRandomWalkMovingBackgroundObject_Number_10 = UnknownVarFromRandomWalkMovingBackgroundObject_Number_8;
            UnknownVarFromRandomWalkMovingBackgroundObject_Number_11 = UnknownVarFromRandomWalkMovingBackgroundObject_Number_9;
            UnknownVarFromRandomWalkMovingBackgroundObject_Number_8 = (Math.random() * 2 - 1) * UnknownVarFromRandomWalkMovingBackgroundObject_Number_1;
            UnknownVarFromRandomWalkMovingBackgroundObject_Number_9 = (Math.random() * 2 - 1) * UnknownVarFromRandomWalkMovingBackgroundObject_Number_2;
            UnknownVarFromRandomWalkMovingBackgroundObject_Uint_2 = UnknownVarFromRandomWalkMovingBackgroundObject_Uint_1;
         }
         var _loc4_:int = window.width;
         var _loc2_:int = window.height;
         var _loc3_:Number = (UnknownVarFromRandomWalkMovingBackgroundObject_Uint_1 - UnknownVarFromRandomWalkMovingBackgroundObject_Uint_2) / UnknownVarFromRandomWalkMovingBackgroundObject_Number_5;
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_6 += param1 / 1000 * (UnknownVarFromRandomWalkMovingBackgroundObject_Number_3 + UnknownHabboUtils1.lerp(_loc3_,UnknownVarFromRandomWalkMovingBackgroundObject_Number_10,UnknownVarFromRandomWalkMovingBackgroundObject_Number_8));
         UnknownVarFromRandomWalkMovingBackgroundObject_Number_7 += param1 / 1000 * (UnknownVarFromRandomWalkMovingBackgroundObject_Number_4 + UnknownHabboUtils1.lerp(_loc3_,UnknownVarFromRandomWalkMovingBackgroundObject_Number_11,UnknownVarFromRandomWalkMovingBackgroundObject_Number_9));
         sprite.x = UnknownVarFromRandomWalkMovingBackgroundObject_Number_6;
         sprite.y = UnknownVarFromRandomWalkMovingBackgroundObject_Number_7;
         if(UnknownVarFromRandomWalkMovingBackgroundObject_Number_3 > 0 && sprite.x > _loc4_ || UnknownVarFromRandomWalkMovingBackgroundObject_Number_3 < 0 && sprite.x + sprite.width < 0 || UnknownVarFromRandomWalkMovingBackgroundObject_Number_4 > 0 && sprite.y > _loc2_ || UnknownVarFromRandomWalkMovingBackgroundObject_Number_4 < 0 && sprite.y + sprite.height < 0)
         {
            UnknownVarFromRandomWalkMovingBackgroundObject_Number_6 = UnknownVarFromRandomWalkMovingBackgroundObject_Int_1;
            UnknownVarFromRandomWalkMovingBackgroundObject_Number_7 = UnknownVarFromRandomWalkMovingBackgroundObject_Int_2;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
      }
   }
}

