package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
   
   [SecureSWF(rename="true")]
   public class TradingItemListParser implements IMessageParser
   {
      private var _firstUserID:int;
      
      private var _firstUserItemArray:Array;
      
      private var _firstUserNumItems:int;
      
      private var _firstUserNumCredits:int;
      
      private var _secondUserID:int;
      
      private var _secondUserItemArray:Array;
      
      private var _secondUserNumItems:int;
      
      private var _secondUserNumCredits:int;
      
      public function TradingItemListParser()
      {
         super();
      }
      
      public function get firstUserID() : int
      {
         return _firstUserID;
      }
      
      public function get firstUserItemArray() : Array
      {
         return _firstUserItemArray;
      }
      
      public function get firstUserNumItems() : int
      {
         return _firstUserNumItems;
      }
      
      public function get firstUserNumCredits() : int
      {
         return _firstUserNumCredits;
      }
      
      public function get secondUserID() : int
      {
         return _secondUserID;
      }
      
      public function get secondUserItemArray() : Array
      {
         return _secondUserItemArray;
      }
      
      public function get secondUserNumItems() : int
      {
         return _secondUserNumItems;
      }
      
      public function get secondUserNumCredits() : int
      {
         return _secondUserNumCredits;
      }
      
      public function flush() : Boolean
      {
         _firstUserID = -1;
         _firstUserItemArray = null;
         _firstUserNumItems = 0;
         _firstUserNumCredits = 0;
         _secondUserID = -1;
         _secondUserItemArray = null;
         _secondUserNumItems = 0;
         _secondUserNumCredits = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _firstUserID = param1.readInteger();
         _firstUserItemArray = [];
         if(!parseItemData(param1,_firstUserItemArray))
         {
            return false;
         }
         _firstUserNumItems = param1.readInteger();
         _firstUserNumCredits = param1.readInteger();
         _secondUserID = param1.readInteger();
         _secondUserItemArray = [];
         if(!parseItemData(param1,_secondUserItemArray))
         {
            return false;
         }
         _secondUserNumItems = param1.readInteger();
         _secondUserNumCredits = param1.readInteger();
         return true;
      }
      
      private function parseItemData(param1:IMessageDataWrapper, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = param1.readInteger();
         while(_loc3_ > 0)
         {
            param2.push(new ItemDataStructure(param1));
            _loc3_--;
         }
         return true;
      }
   }
}

