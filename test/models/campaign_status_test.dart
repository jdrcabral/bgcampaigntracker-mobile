import 'package:campaigntrackerflutter/models/campaign_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Campaign Status update nested value list', () async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'characters': [
          {
            'name': 'Old Value',
            'inventory': [
              {
                'name': 'Item',
                'quantity': '10',
              },
              {
                'name': 'Item2',
                'quantity': '15',
              },
            ],
          },
          {
            'name': 'Test',
            'inventory': [
              {
                'name': 'Item3',
                'quantity': '10',
              },
              {
                'name': 'Item4',
                'quantity': '15',
              },
            ],
          },
        ],
      }
    );

    campaignSavedStatus.updateNestedValue('characters.0.name', 'New Value');
    expect(campaignSavedStatus.savedState['characters'][0]['name'], 'New Value');

    campaignSavedStatus.updateNestedValue('characters.1.inventory.1.quantity', '2');
    expect(campaignSavedStatus.savedState['characters'][1]['inventory'][1]['quantity'], '2');
  });

  test('Campaign Status update nested value map', () async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'characters': [
          {
            'name': 'Old Value',
            'status': {
              'unlockded': false,
              'dead': false,
            },
          }
        ],
      }
    );

    campaignSavedStatus.updateNestedValue('characters.0.status.dead', true);
    expect(campaignSavedStatus.savedState['characters'][0]['status']['dead'], true);
  });

    test('Campaign Status update nested value list', () async {
    CampaignSavedStatus campaignSavedStatus = CampaignSavedStatus(
      savedState: {
        'cards': [
          'Item A',
          'Item B',
          'Item C',
        ],
      }
    );

    campaignSavedStatus.updateNestedValue('cards.1', 'Item D');
    expect(campaignSavedStatus.savedState['cards'][1], 'Item D');
  });
}
