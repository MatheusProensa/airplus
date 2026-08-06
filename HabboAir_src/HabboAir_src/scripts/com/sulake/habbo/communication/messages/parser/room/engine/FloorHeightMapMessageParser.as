package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FloorHeightMapMessageParser implements IMessageParser
   {
      private var _text:String = "";
      
      private var UnknownVarFromFloorHeightMapMessageParser_Array_1:Array = [];
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _scale:Number = 0;
      
      private var _fixedWallsHeight:int = -1;
      
      private var _areaHideData:Vector.<AreaHideMessageData>;
      
      private var _cameraInitX:int;
      
      private var _cameraInitY:int;
      
      private var _cameraInitZ:Number;
      
      public function FloorHeightMapMessageParser()
      {
         super();
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get fixedWallsHeight() : int
      {
         return _fixedWallsHeight;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function getTileHeight(param1:int, param2:int) : int
      {
         if(param1 < 0 || param1 >= width || param2 < 0 || param2 >= height)
         {
            return -110;
         }
         var _loc3_:Array = UnknownVarFromFloorHeightMapMessageParser_Array_1[param2] as Array;
         return _loc3_[param1];
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromFloorHeightMapMessageParser_Array_1 = [];
         _width = 0;
         _height = 0;
         _text = "";
         _fixedWallsHeight = -1;
         _areaHideData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc8_:String = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc9_:Boolean = param1.readBoolean();
         _fixedWallsHeight = param1.readInteger();
         _text = param1.readString();
         var _loc6_:Array = _text.split("\r");
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:Array = null;
         var _loc12_:int = int(_loc6_.length);
         if(_loc12_ > 0 && _loc6_[_loc12_ - 1] == "")
         {
            _loc12_ -= 1;
         }
         var _loc7_:int = 0;
         var _loc10_:String = null;
         _loc4_ = 0;
         while(_loc4_ < _loc12_)
         {
            _loc10_ = _loc6_[_loc4_] as String;
            if(_loc10_.length > _loc7_)
            {
               _loc7_ = _loc10_.length;
            }
            _loc4_++;
         }
         UnknownVarFromFloorHeightMapMessageParser_Array_1 = [];
         _loc4_ = 0;
         while(_loc4_ < _loc12_)
         {
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < _loc7_)
            {
               _loc2_.push(-110);
               _loc3_++;
            }
            UnknownVarFromFloorHeightMapMessageParser_Array_1.push(_loc2_);
            _loc4_++;
         }
         _width = _loc7_;
         _height = _loc12_;
         _loc4_ = 0;
         while(_loc4_ < _loc12_)
         {
            _loc2_ = UnknownVarFromFloorHeightMapMessageParser_Array_1[_loc4_] as Array;
            _loc10_ = _loc6_[_loc4_] as String;
            if(_loc10_.length > 0)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_.length)
               {
                  _loc8_ = _loc10_.charAt(_loc3_);
                  if(_loc8_ != "x" && _loc8_ != "X")
                  {
                     _loc11_ = parseInt(_loc8_,36);
                  }
                  else
                  {
                     _loc11_ = -110;
                  }
                  _loc2_[_loc3_] = _loc11_;
                  _loc3_++;
               }
            }
            _loc4_++;
         }
         _scale = _loc9_ ? 32 : 64;
         _areaHideData = new Vector.<AreaHideMessageData>();
         var _loc13_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc13_)
         {
            _areaHideData.push(new AreaHideMessageData(param1));
            _loc5_++;
         }
         _cameraInitX = param1.readInteger();
         _cameraInitY = param1.readInteger();
         _cameraInitZ = param1.readFloat();
         return true;
      }
      
      public function get areaHideData() : Vector.<AreaHideMessageData>
      {
         return _areaHideData;
      }
      
      public function get cameraInitX() : int
      {
         return _cameraInitX;
      }
      
      public function get cameraInitY() : int
      {
         return _cameraInitY;
      }
      
      public function get cameraInitZ() : Number
      {
         return _cameraInitZ;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}

