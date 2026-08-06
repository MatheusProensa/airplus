package com.sulake.habbo.communication.messages.incoming.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class TopLevelContext
   {
      private var _searchCode:String;
      
      private var _quickLinks:Vector.<SavedSearch>;
      
      public function TopLevelContext(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _quickLinks = new Vector.<SavedSearch>(0);
         super();
         _searchCode = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            quickLinks.push(new SavedSearch(param1));
            _loc3_++;
         }
      }
      
      public function get searchCode() : String
      {
         return _searchCode;
      }
      
      public function get quickLinks() : Vector.<SavedSearch>
      {
         return _quickLinks;
      }
   }
}

