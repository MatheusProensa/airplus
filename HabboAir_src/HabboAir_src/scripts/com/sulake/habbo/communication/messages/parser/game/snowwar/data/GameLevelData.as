package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class GameLevelData
   {
      private var _width:int;
      
      private var _height:int;
      
      private var _heightMap:String;
      
      private var _fuseObjects:Array = [];
      
      public function GameLevelData(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get heightMap() : String
      {
         return _heightMap;
      }
      
      public function get fuseObjects() : Array
      {
         return _fuseObjects;
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var _loc3_:int = 0;
         var _loc4_:FuseObjectData = null;
         _width = param1.readInteger();
         _height = param1.readInteger();
         _heightMap = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new FuseObjectData();
            _loc4_.parse(param1);
            _fuseObjects.push(_loc4_);
            _loc3_++;
         }
      }
   }
}

