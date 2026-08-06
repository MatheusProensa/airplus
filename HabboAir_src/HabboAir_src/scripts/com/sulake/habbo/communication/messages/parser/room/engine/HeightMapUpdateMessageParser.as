package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HeightMapUpdateMessageParser implements IMessageParser
   {
      private var UnknownVarFromHeightMapUpdateMessageParser_IMessageDataWrapper_1:IMessageDataWrapper;
      
      private var _count:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var UnknownVarFromHeightMapUpdateMessageParser_Int_1:int;
      
      private var UnknownVarFromHeightMapUpdateMessageParser_Int_2:int = 16384;
      
      private var UnknownVarFromHeightMapUpdateMessageParser_Int_3:int = 16383;
      
      public function HeightMapUpdateMessageParser()
      {
         super();
      }
      
      public function set stackingBlockedMaskBit(param1:int) : void
      {
         UnknownVarFromHeightMapUpdateMessageParser_Int_2 = 1 << param1;
         UnknownVarFromHeightMapUpdateMessageParser_Int_3 = UnknownVarFromHeightMapUpdateMessageParser_Int_2 - 1;
      }
      
      public function next() : Boolean
      {
         if(_count == 0)
         {
            return false;
         }
         _count--;
         _x = UnknownVarFromHeightMapUpdateMessageParser_IMessageDataWrapper_1.readByte();
         _y = UnknownVarFromHeightMapUpdateMessageParser_IMessageDataWrapper_1.readByte();
         UnknownVarFromHeightMapUpdateMessageParser_Int_1 = UnknownVarFromHeightMapUpdateMessageParser_IMessageDataWrapper_1.readShort();
         return true;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get tileHeight() : Number
      {
         return HeightMapMessageParser.decodeTileHeight(UnknownVarFromHeightMapUpdateMessageParser_Int_1,UnknownVarFromHeightMapUpdateMessageParser_Int_3);
      }
      
      public function get isStackingBlocked() : Boolean
      {
         return HeightMapMessageParser.decodeIsStackingBlocked(UnknownVarFromHeightMapUpdateMessageParser_Int_1,UnknownVarFromHeightMapUpdateMessageParser_Int_2);
      }
      
      public function get isRoomTile() : Boolean
      {
         return HeightMapMessageParser.decodeIsRoomTile(UnknownVarFromHeightMapUpdateMessageParser_Int_1);
      }
      
      public function flush() : Boolean
      {
         _count = 0;
         UnknownVarFromHeightMapUpdateMessageParser_IMessageDataWrapper_1 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         UnknownVarFromHeightMapUpdateMessageParser_IMessageDataWrapper_1 = param1;
         _count = param1.readByte();
         return true;
      }
   }
}

