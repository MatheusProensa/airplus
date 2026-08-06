package com.sulake.habbo.communication.messages.parser.landingview
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.landingview.PromoArticleData;
   
   [SecureSWF(rename="true")]
   public class PromoArticlesMessageParser implements IMessageParser
   {
      private var _articles:Array;
      
      public function PromoArticlesMessageParser()
      {
         super();
      }
      
      public function get articles() : Array
      {
         return _articles;
      }
      
      public function flush() : Boolean
      {
         _articles = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _articles.push(new PromoArticleData(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

