package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   
   public class CreateSnowballEvent extends SnowWarGameEvent
   {
      private var _snowBallGameObject:SnowBallGameObject;
      
      private var UnknownVarFromCreateSnowballEvent_HumanGameObject_1:HumanGameObject;
      
      private var UnknownVarFromCreateSnowballEvent_Int_1:int;
      
      private var UnknownVarFromCreateSnowballEvent_Int_2:int;
      
      private var UnknownVarFromCreateSnowballEvent_Int_3:int;
      
      public function CreateSnowballEvent(param1:int, param2:HumanGameObject, param3:int, param4:int, param5:int)
      {
         super();
         this._snowBallGameObject = new SnowBallGameObject(param1);
         this.UnknownVarFromCreateSnowballEvent_HumanGameObject_1 = param2;
         this.UnknownVarFromCreateSnowballEvent_Int_1 = param3;
         this.UnknownVarFromCreateSnowballEvent_Int_2 = param4;
         this.UnknownVarFromCreateSnowballEvent_Int_3 = param5;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _snowBallGameObject = null;
         UnknownVarFromCreateSnowballEvent_HumanGameObject_1 = null;
      }
      
      public function set snowBallGameObject(param1:SnowBallGameObject) : void
      {
         this._snowBallGameObject = param1;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         param1.addGameObject(_snowBallGameObject.gameObjectId,_snowBallGameObject);
         _snowBallGameObject.isActive = true;
         var _loc2_:int = UnknownVarFromCreateSnowballEvent_HumanGameObject_1.currentLocation.x;
         var _loc3_:int = UnknownVarFromCreateSnowballEvent_HumanGameObject_1.currentLocation.y;
         var _loc4_:int = 3000;
         _snowBallGameObject.initialize(_loc2_,_loc3_,_loc4_,UnknownVarFromCreateSnowballEvent_Int_3,UnknownVarFromCreateSnowballEvent_Int_1,UnknownVarFromCreateSnowballEvent_Int_2,UnknownVarFromCreateSnowballEvent_HumanGameObject_1);
      }
   }
}

