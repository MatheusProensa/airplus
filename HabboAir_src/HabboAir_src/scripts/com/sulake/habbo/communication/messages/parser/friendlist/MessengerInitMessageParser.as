package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
   
   [SecureSWF(rename="true")]
   public class MessengerInitMessageParser implements IMessageParser
   {
      private var UnknownVarFromMessengerInitMessageParser_Int_1:int;
      
      private var UnknownVarFromMessengerInitMessageParser_Int_2:int;
      
      private var UnknownVarFromMessengerInitMessageParser_Int_3:int;
      
      private var _categories:Array;
      
      public function MessengerInitMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this._categories = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         this.UnknownVarFromMessengerInitMessageParser_Int_1 = param1.readInteger();
         this.UnknownVarFromMessengerInitMessageParser_Int_2 = param1.readInteger();
         this.UnknownVarFromMessengerInitMessageParser_Int_3 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._categories.push(new FriendCategoryData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get userFriendLimit() : int
      {
         return this.UnknownVarFromMessengerInitMessageParser_Int_1;
      }
      
      public function get normalFriendLimit() : int
      {
         return this.UnknownVarFromMessengerInitMessageParser_Int_2;
      }
      
      public function get extendedFriendLimit() : int
      {
         return this.UnknownVarFromMessengerInitMessageParser_Int_3;
      }
      
      public function get categories() : Array
      {
         return this._categories;
      }
   }
}

