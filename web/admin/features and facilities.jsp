<!-- addFeaturesAndFacilities.jsp -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Features and Facilities</title>
</head>
<body>
    <h2>Add Feature</h2>
    <form action="FeaturesAndFacilitiesServlet" method="post">
        <input type="hidden" name="action" value="addFeature">
        <label for="featureName">Feature Name:</label>
        <input type="text" id="featureName" name="featureName">
        <!-- You may add hidden input fields for ID and action if they're not entered by the user -->
        <input type="submit" value="Add Feature">
    </form>

    <h2>Add Facility</h2>
    <form action="FeaturesAndFacilitiesServlet" method="post">
        <input type="hidden" name="action" value="addFacility">
        <label for="facilityIcon">Facility Icon:</label>
        <input type="text" id="facilityIcon" name="facilityIcon">
        <label for="facilityName">Facility Name:</label>
        <input type="text" id="facilityName" name="facilityName">
        <label for="facilityDescription">Facility Description:</label>
        <input type="text" id="facilityDescription" name="facilityDescription">
        <!-- You may add hidden input fields for ID and action if they're not entered by the user -->
        <input type="submit" value="Add Facility">
    </form>
</body>
</html>
