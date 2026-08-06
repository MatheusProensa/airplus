package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CfhTopicsInitMessageParser implements IMessageParser
   {
      private var _callForHelpCategories:Vector.<CallForHelpCategoryData>;
      
      private var _disposed:Boolean;
      
      public function CfhTopicsInitMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_disposed)
         {
            return true;
         }
         _disposed = true;
         for each(var _loc1_ in _callForHelpCategories)
         {
            _loc1_.dispose();
         }
         _callForHelpCategories = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _callForHelpCategories = new Vector.<CallForHelpCategoryData>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _callForHelpCategories.push(new CallForHelpCategoryData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get callForHelpCategories() : Vector.<CallForHelpCategoryData>
      {
         return _callForHelpCategories;
      }
   }
}

