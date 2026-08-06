package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRuleset;
   
   [SecureSWF(rename="true")]
   public class BundleDiscountRulesetMessageParser implements IMessageParser
   {
      private var _bundleDiscountRuleset:BundleDiscountRuleset;
      
      public function BundleDiscountRulesetMessageParser()
      {
         super();
      }
      
      public function get bundleDiscountRuleset() : BundleDiscountRuleset
      {
         return _bundleDiscountRuleset;
      }
      
      public function flush() : Boolean
      {
         _bundleDiscountRuleset = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _bundleDiscountRuleset = new BundleDiscountRuleset(param1);
         return true;
      }
   }
}

