package com.sulake.habbo.friendbar.onBoardingHcSteps
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RandomAvatarCloudsAnimation extends Sprite
   {
      private static const cloud_1_1_png:Class = c1_1_1_png;
      
      private static const cloud_1_2_png:Class = c1_2_1_png;
      
      private static const cloud_1_3_png:Class = c1_3_1_png;
      
      private static const cloud_1_4_png:Class = c1_4_1_png;
      
      private static const cloud_2_1_png:Class = c2_1_1_png;
      
      private static const cloud_2_2_png:Class = c2_2_1_png;
      
      private static const cloud_2_3_png:Class = c2_3_1_png;
      
      private static const cloud_2_4_png:Class = c2_4_1_png;
      
      private static const cloud_3_1_png:Class = c3_1_1_png;
      
      private static const cloud_3_2_png:Class = c3_2_1_png;
      
      private static const cloud_3_3_png:Class = c3_3_1_png;
      
      private static const cloud_3_4_png:Class = c3_4_1_png;
      
      private static const cloud_4_1_png:Class = c4_1_1_png;
      
      private static const cloud_4_2_png:Class = c4_2_1_png;
      
      private static const cloud_4_3_png:Class = c4_3_1_png;
      
      private static const cloud_4_4_png:Class = c4_4_1_png;
      
      private var _leftFrames:Array;
      
      private var _rightFrames:Array;
      
      private var _downFrames:Array;
      
      private var _altFrames:Array;
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Timer_1:Timer;
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Int_1:int;
      
      private var _animationFrame:int;
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1:Sprite;
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2:Sprite;
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3:Sprite;
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Array_1:Array = [-9,-8,-5,-3,3,5,8,9];
      
      private var UnknownVarFromRandomAvatarCloudsAnimation_Int_2:int;
      
      public function RandomAvatarCloudsAnimation()
      {
         super();
         _rightFrames = [new cloud_1_1_png(),new cloud_1_2_png(),new cloud_1_3_png(),new cloud_1_4_png()];
         _leftFrames = [new cloud_2_1_png(),new cloud_2_2_png(),new cloud_2_3_png(),new cloud_2_4_png()];
         _downFrames = [new cloud_3_1_png(),new cloud_3_2_png(),new cloud_3_3_png(),new cloud_3_4_png()];
         _altFrames = [new cloud_4_1_png(),new cloud_4_2_png(),new cloud_4_3_png(),new cloud_4_4_png()];
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function dispose() : void
      {
         if(UnknownVarFromRandomAvatarCloudsAnimation_Timer_1)
         {
            UnknownVarFromRandomAvatarCloudsAnimation_Timer_1.reset();
            UnknownVarFromRandomAvatarCloudsAnimation_Timer_1 = null;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3 = new Sprite();
         addChild(UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1 = new Sprite();
         addChild(UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2 = new Sprite();
         addChild(UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2);
         resetAnimation();
      }
      
      private function resetAnimation() : void
      {
         UnknownVarFromRandomAvatarCloudsAnimation_Int_1 = 0;
         _animationFrame = 0;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.addChild(_downFrames[0]);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.x = 75;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.y = 140;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.addChild(_leftFrames[0]);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.x = 30;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.y = 115;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.addChild(_rightFrames[0]);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.x = 85;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.y = 110;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.visible = true;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.visible = true;
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.visible = true;
      }
      
      public function startAnimation() : void
      {
         resetAnimation();
         if(!UnknownVarFromRandomAvatarCloudsAnimation_Timer_1)
         {
            UnknownVarFromRandomAvatarCloudsAnimation_Timer_1 = new Timer(80);
            UnknownVarFromRandomAvatarCloudsAnimation_Timer_1.addEventListener("timer",onAnimateTimer);
         }
         var _loc1_:int = Math.round(Math.random() * (UnknownVarFromRandomAvatarCloudsAnimation_Array_1.length - 1));
         UnknownVarFromRandomAvatarCloudsAnimation_Int_2 = UnknownVarFromRandomAvatarCloudsAnimation_Array_1[_loc1_];
         UnknownVarFromRandomAvatarCloudsAnimation_Timer_1.start();
      }
      
      private function onAnimateTimer(param1:TimerEvent) : void
      {
         if(UnknownVarFromRandomAvatarCloudsAnimation_Timer_1 == null)
         {
            return;
         }
         UnknownVarFromRandomAvatarCloudsAnimation_Int_1++;
         if(UnknownVarFromRandomAvatarCloudsAnimation_Int_1 > 2 && UnknownVarFromRandomAvatarCloudsAnimation_Int_1 < 5)
         {
            _animationFrame = 1;
         }
         else if(UnknownVarFromRandomAvatarCloudsAnimation_Int_1 > 4 && UnknownVarFromRandomAvatarCloudsAnimation_Int_1 < 7)
         {
            _animationFrame = 2;
         }
         else if(UnknownVarFromRandomAvatarCloudsAnimation_Int_1 > 6 && UnknownVarFromRandomAvatarCloudsAnimation_Int_1 < 9)
         {
            _animationFrame = 3;
         }
         else if(UnknownVarFromRandomAvatarCloudsAnimation_Int_1 >= 9)
         {
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.visible = false;
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.visible = false;
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.visible = false;
         }
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.removeChildAt(0);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.removeChildAt(0);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.removeChildAt(0);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.addChild(_downFrames[_animationFrame]);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.addChild(_leftFrames[_animationFrame]);
         UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.addChild(_rightFrames[_animationFrame]);
         var _loc2_:int = Math.round(Math.random() * 10);
         if(_loc2_ % 2 != 0)
         {
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.removeChildAt(0);
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.addChild(_altFrames[_animationFrame]);
         }
         else
         {
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.removeChildAt(0);
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.addChild(_altFrames[_animationFrame]);
         }
         if(UnknownVarFromRandomAvatarCloudsAnimation_Int_1 <= 9)
         {
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.x += 10 + Math.random() * 5;
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_2.y -= UnknownVarFromRandomAvatarCloudsAnimation_Int_2;
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.x -= 10 + Math.random() * 5;
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_1.y -= UnknownVarFromRandomAvatarCloudsAnimation_Int_2;
            UnknownVarFromRandomAvatarCloudsAnimation_Sprite_3.y += UnknownVarFromRandomAvatarCloudsAnimation_Int_2 * 1.3;
         }
      }
   }
}

