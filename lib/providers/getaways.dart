import 'package:flutter/foundation.dart';
import 'package:playground/providers/getaway.dart';

class GetawaysProvider with ChangeNotifier {
  final List<Getaway> _items = [
    // Getaway(
    //     id: 1,
    //     title: "Yacht rent Azimut Flybridge in Paradise Harbour, Nassau (2010, refit 2020)",
    //     price: 1600.55,
    //     fee: "50",
    //     deposit: 120.23,
    //     pay_in_parts: 5,
    //     images: [
    //         "https://lav.playground.wdscode.guru/storage/getaways/1652774224yacht-rent.jpg",
    //         "https://lav.playground.wdscode.guru/storage/getaways/1652774224yacht-rent3.jpg"
    //     ],
    //     description: "95' Azimut Flybridge yacht available for overnight trips to the Bahamas.Great condition, newly refit with incredible 5 star service.Water toys and snorkeling gear included!Explore the beautiful bay by boat! Book this 95' Azimut Flybridge Power Mega Yacht that can accommodate up to 9 people overnight... Rates starting as low as \$6,000 per day.You can cruise to the Bahamas and many more destinations.*A minimum 10-15% tip is mandatory for crew members and is not included in the charter prices.Rates include: Captain and crew members Boat pick up and drop off at the Marina Fun water activities for adults and kids Dinghy Water googles Water tubes Snorkeling gear Paddle Boards Full tank of Gas We provide towels, drinks, sodas, water, ice, etc. A brand new blue-tooth speaker system installed Brand new amplifier systems What You Can Expect:Enjoy this 5-star rated yacht from Azimut boat yard while discovering the beautiful destinations all around the Bahamas, Bimini, and many more!Expect comfort, excellent service, and a great time!If you have any questions we can answer them in the messaging platform before you pay.",
    //     date_time: "2022-04-25 04:12:11",
    //     duration_hours: 12,
    //     duration_minutes: 50,
    //     payment_type: "stripe",
    //     payment_parts_amount: 0,
    //     terms_and_conditions: "<p style=\"text-align: center;\"><strong>General Terms and Conditions of Service «Nautal» (May 2021) </strong></p><p style=\"text-align: left;\">The general conditions of use described below are a proposed translation in order to facilitate the understanding of the service to the users. </p><p style=\"text-align: left;\">1. Definitions </p><p style=\"text-align: left;\">The terms defined below have these general conditions and the meanings attributed to them are below the terms each time they start with a capital letter, whether they are used in the singular or in the plural. Listing: designates a Rental or Co-navigation published by the boat Owner on the website. General Conditions of the Service: designates to these general conditions of use Nautal: designates to the company Nautal, a simplified joint stock company whose registered office is at Josep Pla 2,B3,6B 08019, Barcelona, España, with the CIF B66034539, registered in the Barcelona Mercantile Registry. Co-navigation: designates the navigation activity sharing the costs of owning, maintaining and using the Boat. This participation calculated by the Owner under his sole responsibility, must be strictly limited to a share of those expenses. The Owner is prohibited from taking any benefit from Co-navigating. The Owner acknowledges and accepts that the perception of any amount that exceeds the simple distribution of expenses could lead to the reclassification of Co-navigation as a transportation activity, Nautal declining any responsibility that may derive from this reclassification, Nautal Commissions: designates a percentage of commission included in the price but paid by the Owner to Nautal as remuneration for the intermediation service that Nautal provides to the Owner. So the customer is not the one who pays the Nautal commission. The amount of this commission is liable to vary depending on the contractual agreement between Nautal and the Owner. Nautal Tax: These take into account the costs related to the operation of our platform that allow us to offer services such as Customer Service during your trip. VAT included Content: designates all text, graphic, image, video, information or other elements that Users post, upload, publish, send, transmit or include in their Listing or User account so that it is available on the Website. Boat: designates any Nautal vessel put up for rent on the Website (such as sailboats, motorboats, barges, catamarans, jet skis etc.), Renter: designates any natural or legal person who books a boat for rent or for Co-navigation, Rental: designates the rental of a Boat to a Renter by any Owner at the dock or at the sea Additional Options: designates the options that the Renter can subscribe apart from the Owner’s Price (bed linen costs, cleaning, etc.), Start Date: designates the start of the Rental or arrival at the Boat on the first day of the Rental / or Co-navigation, The time of cleaning, refueling and check-in and check-out is part of the rental period provided for in the contract. Renter Price: designates the price shown in the Owner Listing without the additional options. The renter’s price does not include neither the place of the Boat in the ort nor the amount of fuel, except if the opposite is specified in the announcement. Owner’s Price: designates the price freely chosen by the Owner at the moment of publication of his Listing, with the Nautal Commission included, Owner: designates any natural or legal person, professional or private, who, claiming to be the owner or possessor of a Boat, offers their Boat for rent on the Nautal website. By extension, it also designates the representative of an Owner, this representative having to justify the existence and possession of the power he has received. Professional Owner: designates any owner or holder who uses the Service in a professional capacity and whose activity is declared in the Mercantile Registry in accordance with the regulations in force in the locality, region and country where the Professional Owner carries out his activity, Private Owner: designates any owner or holder who does not use the Service in a professional capacity in accordance with the regulations in force in the locality, region and country where the Private Owner carries out his activity. Service: designates the set (i) of the service that puts Owners and Renters in contact to facilitate the Co-navigation or Boat Rental at the dock or at the sea and (ii) the reservation management tool and of payments between Users, Website: designates the website www.nautal.com and the mobile application Nautal, Users: designates any user of the Website and the Service whether they are the Owner or the Renter.</p>",
    //     created_by_id: 1,
    //     created_at: "2022-04-25T16:12:11.000000Z",
    //     updated_at: "2022-05-17T07:57:04.000000Z"
    // ),

// .....Oter Items
  ];

  List<Getaway> get items {
    return [..._items];
  }

  Getaway findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
