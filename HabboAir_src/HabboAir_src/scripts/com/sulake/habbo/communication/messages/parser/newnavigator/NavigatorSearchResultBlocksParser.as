package com.sulake.habbo.communication.messages.parser.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultSet;
   
   [SecureSWF(rename="true")]
   public class NavigatorSearchResultBlocksParser implements IMessageParser
   {
      private var _searchResult:SearchResultSet;
      
      public function NavigatorSearchResultBlocksParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _searchResult = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _searchResult = new SearchResultSet(param1);
         return true;
      }
      
      public function get searchResult() : SearchResultSet
      {
         return _searchResult;
      }
   }
}

