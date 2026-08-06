package com.sulake.habbo.catalog.offers
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IOfferProvider extends IComponentInterfaceQueue
   {
      function get enabled() : Boolean;
      
      function load() : void;
      
      function showVideo() : void;
      
      function get videoAvailable() : Boolean;
      
      function get showingPopup() : Boolean;
   }
}

