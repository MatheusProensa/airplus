package com.sulake.habbo.catalog.offers
{
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Timer;
   
   public class SponsorPayProvider implements IOfferProvider
   {
      private static const LOADED_CALLBACK:String = "sponsorPayLoaded";
      
      private static const ON_START_CALLBACK:String = "sponsorPayOnStart";
      
      private static const NO_OFFERS_CALLBACK:String = "sponsorPayNoOffers";
      
      private static const ON_CLOSE_CALLBACK:String = "sponsorPayOnClose";
      
      private static const ON_CONVERSION_CALLBACK:String = "sponsorPayOnConversion";
      
      private static const UnknownConstFromSponsorPayProvider_String_1:String = "SponsorPay.loadIntegration";
      
      private static const SHOW_VIDEO_FUNCTION:String = "SponsorPay.showVideo";
      
      private static const BACKGROUND_LOAD_FUNCTION:String = "SponsorPay.backgroundLoad";
      
      private static const UnknownConstFromSponsorPayProvider_Int_1:int = 150000;
      
      private var _disposed:Boolean;
      
      private var _offerCenter:OfferCenter;
      
      private var _loaded:Boolean;
      
      private var _videoAvailable:Boolean;
      
      private var _showingPopup:Boolean;
      
      private var UnknownVarFromSponsorPayProvider_Timer_1:Timer;
      
      public function SponsorPayProvider(param1:OfferCenter)
      {
         super();
         _offerCenter = param1;
         if(!enabled)
         {
            return;
         }
         ExternalInterface.addCallback("sponsorPayLoaded",sponsorPayLoaded);
         ExternalInterface.addCallback("sponsorPayOnStart",sponsorPayOnStart);
         ExternalInterface.addCallback("sponsorPayNoOffers",sponsorPayNoOffers);
         ExternalInterface.addCallback("sponsorPayOnClose",sponsorPayOnClose);
         ExternalInterface.addCallback("sponsorPayOnConversion",sponsorPayOnConversion);
         UnknownVarFromSponsorPayProvider_Timer_1 = new Timer(150000,1);
         UnknownVarFromSponsorPayProvider_Timer_1.addEventListener("timer",onResetTimer);
      }
      
      private function onResetTimer(param1:TimerEvent) : void
      {
         sponsorPayOnClose();
      }
      
      public function load() : void
      {
         if(_loaded)
         {
            sponsorPayLoaded();
            return;
         }
         if(enabled)
         {
            try
            {
               ExternalInterface.call("SponsorPay.loadIntegration",appId);
               _loaded = true;
            }
            catch(e:Error)
            {
               Logger.log("External interface not working. Could not call SponsorPay.loadIntegration: " + e);
            }
         }
      }
      
      private function get appId() : String
      {
         return _offerCenter.configuration.getProperty("offers.sponsorpay.appid");
      }
      
      public function showVideo() : void
      {
         if(_loaded && enabled)
         {
            try
            {
               ExternalInterface.call("SponsorPay.showVideo");
               _showingPopup = true;
               UnknownVarFromSponsorPayProvider_Timer_1.reset();
               UnknownVarFromSponsorPayProvider_Timer_1.start();
               updateVideoStatus();
            }
            catch(e:Error)
            {
               Logger.log("External interface not working. Could not call SponsorPay.showVideo: " + e);
            }
         }
      }
      
      public function sponsorPayLoaded() : void
      {
         if(_showingPopup)
         {
            return;
         }
         _videoAvailable = false;
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("SponsorPay.backgroundLoad");
            }
            else
            {
               Logger.log("External interface not available. Could not call SponsorPay.backgroundLoad.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not call SponsorPay.backgroundLoad: " + e);
         }
      }
      
      public function sponsorPayOnStart(param1:String) : void
      {
         _videoAvailable = true;
         updateVideoStatus();
      }
      
      public function sponsorPayNoOffers() : void
      {
         _videoAvailable = false;
         updateVideoStatus();
      }
      
      public function sponsorPayOnClose() : void
      {
         _showingPopup = false;
         if(UnknownVarFromSponsorPayProvider_Timer_1)
         {
            UnknownVarFromSponsorPayProvider_Timer_1.stop();
         }
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("SponsorPay.backgroundLoad");
            }
            else
            {
               Logger.log("External interface not available. Could not call SponsorPay.backgroundLoad.");
            }
         }
         catch(e:Error)
         {
            Logger.log("External interface not working. Could not call SponsorPay.backgroundLoad: " + e);
         }
         finally
         {
            updateVideoStatus();
         }
      }
      
      public function sponsorPayOnConversion() : void
      {
         if(_offerCenter != null)
         {
            _offerCenter.showSuccess();
         }
      }
      
      private function updateVideoStatus() : void
      {
         if(_offerCenter != null)
         {
            _offerCenter.updateVideoStatus();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("sponsorPayLoaded",null);
            ExternalInterface.addCallback("sponsorPayOnStart",null);
            ExternalInterface.addCallback("sponsorPayNoOffers",null);
            ExternalInterface.addCallback("sponsorPayOnClose",null);
            ExternalInterface.addCallback("sponsorPayOnConversion",null);
         }
         if(UnknownVarFromSponsorPayProvider_Timer_1 != null)
         {
            UnknownVarFromSponsorPayProvider_Timer_1.removeEventListener("timer",onResetTimer);
            UnknownVarFromSponsorPayProvider_Timer_1.stop();
            UnknownVarFromSponsorPayProvider_Timer_1 = null;
         }
         _offerCenter = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get videoAvailable() : Boolean
      {
         return _videoAvailable;
      }
      
      public function get showingPopup() : Boolean
      {
         return _showingPopup;
      }
      
      public function get enabled() : Boolean
      {
         return appId != "" && ExternalInterface.available;
      }
   }
}

