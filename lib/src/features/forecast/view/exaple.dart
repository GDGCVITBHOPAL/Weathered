
// return Scaffold(
//       body: Column(
//         children: [
//           const Gap(8),
//           Center(
//             child: Text(
//               'Forecast',
//               style: AppStyle.textTheme.titleLarge,
//             ),
//           ),
//           const Gap(8),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: ListView.builder(
//                 itemCount: 7,
//                 itemBuilder: (context, index) {
//                   return MatContainer.primary(
//                       context: context,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     forecastData[index][0],
//                                     style: AppStyle.textTheme.titleSmall,
//                                   ),
//                                   Text(forecastData[index][1]),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 // Replace this with a svg definer based on what data is supplied by the api
//                                 SvgPicture.asset(
//                                   "assets/icons/weather/heavyrain_thunder.svg",
//                                   height: 64,
//                                 ),
//                                 const Gap(10),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(forecastData[index][2]),
//                                     Text(forecastData[index][3]),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );