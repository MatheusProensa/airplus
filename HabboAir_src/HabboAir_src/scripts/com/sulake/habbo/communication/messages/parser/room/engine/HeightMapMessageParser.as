package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HeightMapMessageParser implements IMessageParser
   {
      private var UnknownVarFromHeightMapMessageParser_Int_1:int = 16384;
      
      private var UnknownVarFromHeightMapMessageParser_Int_2:int = 16383;
      
      private var UnknownVarFromHeightMapMessageParser_Vector_1:Vector.<int>;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      public function HeightMapMessageParser()
      {
         super();
      }
      
      public static function decodeTileHeight(param1:int, param2:int) : Number
      {
         return param1 == -1 ? -1 : (param1 & param2) / 256;
      }
      
      public static function decodeIsStackingBlocked(param1:int, param2:int) : Boolean
      {
         return Boolean(param1 & param2);
      }
      
      public static function decodeIsRoomTile(param1:int) : Boolean
      {
         return param1 != -1;
      }
      
      public function decodeTileHeight(param1:int) : Number
      {
         return HeightMapMessageParser.decodeTileHeight(param1,UnknownVarFromHeightMapMessageParser_Int_2);
      }
      
      public function decodeIsStackingBlocked(param1:int) : Boolean
      {
         return HeightMapMessageParser.decodeIsStackingBlocked(param1,UnknownVarFromHeightMapMessageParser_Int_1);
      }
      
      public function set stackingBlockedMaskBit(param1:int) : void
      {
         UnknownVarFromHeightMapMessageParser_Int_1 = 1 << param1;
         UnknownVarFromHeightMapMessageParser_Int_2 = UnknownVarFromHeightMapMessageParser_Int_1 - 1;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function getTileHeight(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return -1;
         }
         return decodeTileHeight(UnknownVarFromHeightMapMessageParser_Vector_1[param2 * _width + param1]);
      }
      
      public function getStackingBlocked(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return true;
         }
         return decodeIsStackingBlocked(UnknownVarFromHeightMapMessageParser_Vector_1[param2 * _width + param1]);
      }
      
      public function isRoomTile(param1:int, param2:int) : Boolean
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= _height)
         {
            return false;
         }
         return decodeIsRoomTile(UnknownVarFromHeightMapMessageParser_Vector_1[param2 * _width + param1]);
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromHeightMapMessageParser_Vector_1 = null;
         _width = 0;
         _height = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         _width = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _height = _loc3_ / _width;
         UnknownVarFromHeightMapMessageParser_Vector_1 = new Vector.<int>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            UnknownVarFromHeightMapMessageParser_Vector_1[_loc2_] = param1.readShort();
            _loc2_++;
         }
         return true;
      }
   }
}

