package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class UserSongDisksInventoryMessageParser implements IMessageParser
   {
      private var UnknownVarFromUserSongDisksInventoryMessageParser_Map_1:Map;
      
      public function UserSongDisksInventoryMessageParser()
      {
         super();
         UnknownVarFromUserSongDisksInventoryMessageParser_Map_1 = new Map();
      }
      
      public function get songDiskCount() : int
      {
         return UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.length;
      }
      
      public function getDiskId(param1:int) : int
      {
         if(param1 >= 0 && param1 < UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.length)
         {
            return UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.getKey(param1);
         }
         return -1;
      }
      
      public function getSongId(param1:int) : int
      {
         if(param1 >= 0 && param1 < UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.length)
         {
            return UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.getWithIndex(param1);
         }
         return -1;
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            UnknownVarFromUserSongDisksInventoryMessageParser_Map_1.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
   }
}

