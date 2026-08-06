package com.sulake.habbo.communication.messages.outgoing.camera.json
{
   [SecureSWF(rename="false")]
   public class JsonPoint
   {
      private var _x:int;
      
      private var _y:int;
      
      public function JsonPoint(param1:int, param2:int)
      {
         super();
         this._x = param1;
         this._y = param2;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
   }
}

