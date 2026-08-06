package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class GameClickTarget implements IGameClickTarget
   {
      private static const WIDTH:int = 46;
      
      private static const HEIGHT:int = 60;
      
      private static const UnknownConstFromGameClickTarget_Int_1:int = -23;
      
      private static const UnknownConstFromGameClickTarget_Int_2:int = -48;
      
      private var _id:int = -1;
      
      private var _bitmap:BitmapData;
      
      private var _disposed:Boolean;
      
      public function GameClickTarget(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _bitmap = null;
            _disposed = true;
         }
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         return false;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         if(!param1)
         {
            return;
         }
         if(!_bitmap)
         {
            _bitmap = new BitmapData(46,60,true,0);
         }
         param1.visible = true;
         param1.asset = _bitmap;
         param1.offsetX = -23;
         param1.offsetY = -48;
         param1.alphaTolerance = -1;
      }
   }
}

