//
//  DBManager.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 22/09/22.
//

import Foundation

class DBManager {
    static var sharedInstance = DBManager()
    
    private let reminderDb: ReminderDB
    private let doctorDB: DoctorDB
    private let imagesDB: ImagesDB
    private let emergencyDB: EmergencyDB
    private let ratingDB: RatingDB
    private let reviewDB: ReviewsDB
    private let pharmacyDB: PharmacyDB
    private let productDB: PharmacyProductDB
    private let paymentOptionsDB: PaymentDB
    private let consultationDB: ConsultationDB
    private let cartDB: CartDB
    private let shippingDB: ShippingAddressDB
    private let hospitalDB: HospitalDB
    private let userDB: UserDB
    private let personDetailsDB: PersonDetailsDB
    
    private init() {
        reminderDb = ReminderDB()
        doctorDB = DoctorDB()
        imagesDB = ImagesDB()
        emergencyDB = EmergencyDB()
        ratingDB = RatingDB()
        reviewDB = ReviewsDB()
        pharmacyDB = PharmacyDB()
        productDB = PharmacyProductDB()
        paymentOptionsDB = PaymentDB()
        consultationDB = ConsultationDB()
        cartDB = CartDB()
        shippingDB = ShippingAddressDB()
        hospitalDB = HospitalDB()
        userDB = UserDB()
        personDetailsDB = PersonDetailsDB()
    }
    
    func createTables() -> Bool {
        return reminderDb.createTables() && doctorDB.createTables() && imagesDB.createTable() && emergencyDB.createTable() && ratingDB.createTable() && reviewDB.createTable() && pharmacyDB.createTable() && productDB.createTable() && paymentOptionsDB.createTable() && consultationDB.createTable() && cartDB.createTable() && shippingDB.createTable() && hospitalDB.createTable() && userDB.createUserTables() && personDetailsDB.createPersonDetailsTables()
    }
    
    func addRowToReminder(_ reminder: Reminder) {
        reminderDb.addRowToReminder(reminder)
    }
    
    func getRowsFromReminderTable(forUserId: Int) -> [Reminder] {
        return reminderDb.getRowsFromReminderTable(forUserId: forUserId)
    }
    
    func emptyReminderTable() {
        reminderDb.emptyReminderTable()
    }
    
    func updateReminderDetails(_ field: ReminderChoice,from: String, to: String, reminder: Reminder) {
        reminderDb.updateReminderDetails(field,from: from, to: to, reminder: reminder)
    }

    func dropReminderTable() {
        reminderDb.dropReminderTable()
    }
    
    func getReminderSearchResults(forString: String,status: ReminderState, forDate: String, forUserId: Int)  -> [Reminder] {
        return reminderDb.getSearchResults(for: forString, status: status, forDate: forDate, forUserId: forUserId)
    }
    
    func getAvailableDates(forUserId: Int) -> Set<String> {
        return reminderDb.getAvailableDates(forUserId: forUserId)
    }
    
    func setEarlierMedicinesToMissed(forUserId: Int) {
        reminderDb.setEarlierMedicinesToMissed(forUserId: forUserId)
    }
    
    func deleteReminders(_ reminders: [Reminder]) {
        for reminder in reminders {
            reminderDb.deleteReminders(reminder)
        }
    }
    
    func addAvailableVideoCallTimings(_ timings: DoctorTiming) {
        doctorDB.addAvailableVideoCallTimings(timings)
    }
    
    func addAvailableHospitalTimings(_ timings: DoctorTiming) {
        doctorDB.addAvailableHospitalTimings(timings)
    }
    
    func addDoctorDetailsToTable(_ doctor: Doctor) {
        doctorDB.addDoctorDetailsToTable(doctor)
    }
    
    func dropDoctorDBTables() {
        doctorDB.dropDoctorDBTables()
    }
    
    func emptyDoctorTables() {
        doctorDB.emptyTables()
    }
    
    func getRowsFromDoctorTable() -> [Doctor] {
        return doctorDB.getRowsFromDoctorTable()
    }
    
    func getRowsFromTimingsTable(forTable: WorkShiftTable, index: Int) -> DoctorTiming? {
        return doctorDB.getRowsFromTimingsTable(forTable: forTable, index: index)
    }
    
    func getDoctorSearchResults(for searchString: String,designation: DoctorSpecialization) -> [Doctor] {
        return doctorDB.getDoctorSearchResults(for: searchString, designation: designation)
    }
    
    func getDoctorDetailFromTable(forId: Int) -> Doctor {
        return doctorDB.getDoctorDetailFromTable(forId: forId)
    }
    
    func getDoctorRatingsFromDoctorTable(forDoctorName: String, _ doctorId: Int) -> Double {
        return doctorDB.getDoctorRatingsFromDoctorTable(forDoctorName: forDoctorName, doctorId)
    }
    
    func updateDoctorRatingStarCount(toValue: Int, forColumn: RatingStar, ratingId: Int) {
        doctorDB.updateDoctorRatingStarCount(toValue: toValue, forColumn: forColumn, ratingId: ratingId)
    }
    
    func updateDoctorRatings(forDoctorName: String, doctorId: Int, toRating: Double, raters: Int) {
        return doctorDB.updateDoctorRatings(forDoctorName: forDoctorName, doctorId: doctorId, toRating: toRating, raters: raters)
    }
    
    func updateDoctorReview(_ review: Reviews, forDoctorId: Int) {
        doctorDB.updateDoctorReview(review, forDoctorId: forDoctorId)
    }
    
    func addDoctorReview(_ reviews: Reviews) {
        doctorDB.addDoctorReview(reviews)
    }
    
    func getDoctorReviews(forId: Int) -> [Reviews] {
        return doctorDB.getDoctorReviews(forId: forId)
    }
    
    func getDoctorRatings(forId: Int) -> Ratings {
        return doctorDB.getDoctorRatings(forId: forId)
    }
    
    func addDoctorReviewsAndRatingsToTable(_ doctorRatingsAndReviews: DoctorReviewAndRating) {
        doctorDB.addDoctorReviewsAndRatingsToTable(doctorRatingsAndReviews)
    }
    
    func getDoctorVideoConsultTimingsFromDoctorTable(forDoctorName: String, _ doctorId: Int) -> Int {
        return doctorDB.getDoctorVideoConsultTimingsFromDoctorTable(forDoctorName: forDoctorName, doctorId)
    }
    
    func getDoctorHospitalTimingsFromDoctorTable(forDoctorName: String, _ doctorId: Int) -> Int {
        return doctorDB.getDoctorHospitalTimingsFromDoctorTable(forDoctorName: forDoctorName, doctorId)
    }
    
    func addImage(category: ImageCategory, link: String){
        imagesDB.addImage(category: category, link: link)
    }
    
    func dropImagesTable() {
        imagesDB.dropImagesTable()
    }
    
    func emptyImagesTable() {
        imagesDB.emptyImagesTable()
    }
    
    func getRowsFromImagesTable(forCategory: ImageCategory) -> [String] {
        return imagesDB.getRowsFromImagesTable(forCategory: forCategory)
    }
    
    func addEmergenyContact(_ contact: EmergencyContact) {
        emergencyDB.addEmergenyContact(contact)
    }
    
    func dropEmergencyContactTable() {
        emergencyDB.dropEmergencyContactTable()
    }
    
    func emptyEmergencyContactTable() {
        emergencyDB.emptyEmergencyContactTable()
    }
    
    func getRowsFromEmergencyContactTable() -> [EmergencyContact] {
        return emergencyDB.getRowsFromEmergencyContactTable()
    }
    
    func removeContact(forFirstName: String, forLastName: String, forNumber: String) {
        emergencyDB.removeContact(forFirstName: forFirstName, forLastName: forLastName, forNumber: forNumber)
    }
    
    func getEmergencyContactNumbers() -> [String] {
        emergencyDB.getEmergencyContactNumbers()
    }
    
    func addRating(_ rating: Ratings) {
        ratingDB.addRating(rating)
    }
    
    func dropRatingTable() {
        ratingDB.dropRatingTable()
    }
    
    func emptyRatingTable() {
        ratingDB.emptyRatingTable()
    }
    
    func getRowsFromRatingTable(forId: Int, forCategoryId: Int) -> [Ratings] {
        return ratingDB.getRowsFromRatingTable(forId: forId, forCategoryId: forCategoryId)
    }
    
    func updateStarCount(toValue: Int, forColumn: RatingStar, ratingId: Int, category: RatingAndReviewCategory) {
        ratingDB.updateStarCount(toValue: toValue, forColumn: forColumn, ratingId: ratingId, category: category)
    }
    
    func addReview(_ review: Reviews) {
        reviewDB.addReview(review)
    }
    
    func dropReviewTable() {
        reviewDB.dropReviewTable()
    }
    
    func emptyReviewTable() {
        reviewDB.emptyReviewTable()
    }
    
    func getRowsFromReviewTable(forId: Int, forCategoryId: Int) -> [Reviews] {
        reviewDB.getRowsFromReviewTable(forId: forId, forCategoryId: forCategoryId)
    }
    
    func updateReview(for reviewerName: String,to newReview: Reviews, forPharmacyId: Int) {
        reviewDB.updateReview(for: reviewerName, to: newReview, forPharmacyId: forPharmacyId)
    }
    
    func addPharmacy(_ pharmacy: Pharmacy) {
        pharmacyDB.addPharmacy(pharmacy)
    }
    
    func dropPharmacyTable() {
        pharmacyDB.dropPharmacyTable()
    }
    
    func emptyPharmacyTable() {
        pharmacyDB.emptyPharmacyTable()
    }
    
    func getRowsFromPharmacyTable() -> [Pharmacy] {
        return pharmacyDB.getRowsFromPharmacyTable()
    }
    
    func updatePharmacyDetails(forRow: Int, updateColumn: PharmacyUpdate, toValue: Int) {
        pharmacyDB.updatePharmacyDetails(forRow: forRow, updateColumn: updateColumn, toValue: toValue)
    }
    
    func addProduct(_ product: PharmacyProduct) {
        productDB.addProduct(product)
    }
    
    func dropProductTable() {
        productDB.dropProductTable()
    }
    
    func emptyProductTable() {
        productDB.emptyProductTable()
    }
    
    func getRowsFromProductTable(forPharmacyId: Int, forProductId: Int?) -> [PharmacyProduct] {
        return productDB.getRowsFromProductTable(forPharmacyId: forPharmacyId, forProductId: forProductId)
    }
    
    func addPaymentOption(_ card: CardDetails) {
        paymentOptionsDB.addPaymentOption(card)
    }
    
    func dropPaymentOptionsTable() {
        paymentOptionsDB.dropPaymentOptionsTable()
    }
    
    func emptyPaymentOptionsTable() {
        paymentOptionsDB.emptyPaymentOptionsTable()
    }
    
    func getRowsFromPaymentOptionsTable() -> [CardDetails] {
        return paymentOptionsDB.getRowsFromPaymentOptionsTable()
    }
    
    func addConsultation(_ consultation: ConsultationUpdater) {
        consultationDB.addConsultation(consultation)
    }
    
    func dropConsultationTable() {
        consultationDB.dropConsultationTable()
    }
    
    func emptyConsultationTable() {
        consultationDB.emptyConsultationTable()
    }
    
    func getRowsFromConsultationTable(for state: ConsultationState, forUserId: Int) -> [ConsultationGetter] {
        return consultationDB.getRowsFromConsultationTable(for: state, forUserId: forUserId)
    }
    
    func updateConsultation(date: String,time: String, for consultation: ConsultationUpdater, forUserId: Int) {
        consultationDB.updateConsultation(date: date, time: time, for: consultation, forUserId: forUserId)
    }
    
    func updateConsultation(state: ConsultationState, for consultation: ConsultationGetter, forUserId: Int) {
        consultationDB.updateConsultation(state: state, for: consultation, forUserId: forUserId)
    }
    
    func removeConsultation(_ consultation: ConsultationGetter, forUserId: Int) {
        consultationDB.removeConsultation(consultation, forUserId: forUserId)
    }
    
    func addToCart(_ product: Cart) {
        cartDB.addToCart(product)
    }
    
    func dropCartTable() {
        cartDB.dropCartTable()
    }
    
    func emptyCartTable(forState: ProductStatus, foruserId: Int) {
        cartDB.emptyCartTable(forState: forState, foruserId: foruserId)
    }
    
    func getRowsFromCartTable(forDate: String, forUserId: Int, forState: ProductStatus) -> [Cart] {
        cartDB.getRowsFromCartTable(forDate: forDate, forUserId: forUserId, forState: forState)
    }
    
    func getCartSearchResults(for searchString: String, forUserId: Int) -> [Cart] {
        cartDB.getCartSearchResults(for: searchString, forUserId: forUserId)
    }
    
    func updateProductQuantity(forProductName: String, productCost: Double, toQuantity: Int, forUserId: Int, state: ProductStatus) {
        cartDB.updateProductQuantity(forProductName: forProductName, productCost: productCost, toQuantity: toQuantity, forUserId: forUserId, state: state)
    }
    
    func removeProductFromTable(_ productName: String, _ productCost: Double, date: String,forUserId: Int, state: ProductStatus) {
        cartDB.removeProductFromTable(productName, productCost, date: date, forUserId: forUserId, state: state)
    }
    
    func getStoredDates(forUserId: Int) -> Set<String> {
        cartDB.getStoredDates(forUserId: forUserId)
    }
    
    func getProductOf(state: ProductStatus, forUserId: Int) -> [Cart] {
        cartDB.getProductOf(state: state, forUserId: forUserId)
    }
    
    func updateProduct(toState: ProductStatus, forUserId: Int, forProduct cart: Cart) {
        cartDB.updateProduct(toState: toState, forUserId: forUserId, forProduct: cart)
    }
    
    func createTable() -> Bool {
        return shippingDB.createTable()
    }
    
    func addToShippingAddress(_ shippingAddress: ShippingAddress) {
        shippingDB.addToShippingAddress(shippingAddress)
    }
    
    func dropShippingAddressTable() {
        shippingDB.dropShippingAddressTable()
    }
    
    func emptyShippingAddressTable() {
        shippingDB.emptyShippingAddressTable()
    }
    
    func getRowsFromShippingAddressTable() -> [ShippingAddress] {
        return shippingDB.getRowsFromShippingAddressTable()
    }
    
    func removeAddressFromShippingAddressTable(_ shippingAddress: ShippingAddress) {
        shippingDB.removeAddressFromShippingAddressTable(shippingAddress)
    }
    
    func updateShippingAddress(forId: Int, _ shippingAddress: ShippingAddress) {
        shippingDB.updateShippingAddress(forId: forId, shippingAddress)
    }
    
    func addToHospitalTable(_ hospital: Hospital) {
        hospitalDB.addToHospitalTable(hospital)
    }
    
    func dropHospitalTable() {
        hospitalDB.dropHospitalTable()
    }
    
    func emptyHospitalTable() {
        hospitalDB.emptyHospitalTable()
    }
    
    func getRowsFromHospitalTable() -> [Hospital] {
        hospitalDB.getRowsFromHospitalTable()
    }
    
    func getHospitalSearchResults(for searchString: String) -> [Hospital] {
        hospitalDB.getHospitalSearchResults(for: searchString)
    }
    
    func addUserDetails(_ user: User) {
        userDB.addUserDetails(user)
    }
    
    func updateUserDetails(_ user: User, forId: Int) {
        userDB.updateUserDetails(user, forId: forId)
    }
    
    func getAllUserDetails() -> [User] {
        userDB.getAllUserDetails()
    }
    
    func getUserDetailForId(_ id: Int) -> User {
        userDB.getUserDetailForId(id)
    }
    
    func emptyPersonDetailsTable() {
        personDetailsDB.emptyPersonDetailsTable()
    }
    
    func dropPersonDetailsTable() {
        personDetailsDB.dropPersonDetailsTable()
    }
    
    func addPersonDetails(_ person: Person) {
        personDetailsDB.addPersonDetails(person)
    }
    
    func updatePersonDetails(_ person: Person, forId: Int) {
        personDetailsDB.updatePersonDetails(person, forId: forId)
    }
    
    func getAllPersonDetails() -> [Person] {
        return personDetailsDB.getAllPersonDetails()
    }
    
    func getPersonDetailForId(_ id: Int) -> Person {
        return personDetailsDB.getPersonDetailForId(id)
    }
    
    func removePersonDetail(forId: Int) {
        personDetailsDB.removePersonDetail(forId: forId)
    }
}
