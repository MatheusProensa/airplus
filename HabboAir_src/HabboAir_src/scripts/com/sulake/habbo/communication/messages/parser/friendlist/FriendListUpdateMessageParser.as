package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   
   [SecureSWF(rename="true")]
   public class FriendListUpdateMessageParser implements IMessageParser
   {
      private var UnknownVarFromFriendListUpdateMessageParser_Array_1:Array;
      
      private var UnknownVarFromFriendListUpdateMessageParser_Array_2:Array;
      
      private var UnknownVarFromFriendListUpdateMessageParser_Array_3:Array;
      
      private var UnknownVarFromFriendListUpdateMessageParser_Array_4:Array;
      
      public function FriendListUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.UnknownVarFromFriendListUpdateMessageParser_Array_1 = [];
         this.UnknownVarFromFriendListUpdateMessageParser_Array_2 = [];
         this.UnknownVarFromFriendListUpdateMessageParser_Array_3 = [];
         this.UnknownVarFromFriendListUpdateMessageParser_Array_4 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            this.UnknownVarFromFriendListUpdateMessageParser_Array_1.push(new FriendCategoryData(param1));
            _loc5_++;
         }
         var _loc3_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = param1.readInteger();
            if(_loc6_ == -1)
            {
               _loc4_ = param1.readInteger();
               this.UnknownVarFromFriendListUpdateMessageParser_Array_2.push(_loc4_);
            }
            else if(_loc6_ == 0)
            {
               this.UnknownVarFromFriendListUpdateMessageParser_Array_4.push(new FriendData(param1));
            }
            else if(_loc6_ == 1)
            {
               this.UnknownVarFromFriendListUpdateMessageParser_Array_3.push(new FriendData(param1));
            }
            _loc5_++;
         }
         return true;
      }
      
      public function get cats() : Array
      {
         return this.UnknownVarFromFriendListUpdateMessageParser_Array_1;
      }
      
      public function get removedFriendIds() : Array
      {
         return this.UnknownVarFromFriendListUpdateMessageParser_Array_2;
      }
      
      public function get addedFriends() : Array
      {
         return this.UnknownVarFromFriendListUpdateMessageParser_Array_3;
      }
      
      public function get updatedFriends() : Array
      {
         return this.UnknownVarFromFriendListUpdateMessageParser_Array_4;
      }
   }
}

