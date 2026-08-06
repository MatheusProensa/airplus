package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.BundleDiscountRulesetMessageParser;
   
   [SecureSWF(rename="true")]
   public class BundleDiscountRulesetMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function BundleDiscountRulesetMessageEvent(param1:Function)
      {
         super(param1,BundleDiscountRulesetMessageParser);
      }
      
      public function getParser() : BundleDiscountRulesetMessageParser
      {
         return this._parser as BundleDiscountRulesetMessageParser;
      }
   }
}

